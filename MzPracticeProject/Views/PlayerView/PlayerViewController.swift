//
//  PlayerViewController.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 11/06/2022.
//

import UIKit
import Combine
import AVFoundation

class PlayerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var cancelableObservers:[AnyCancellable] = []
    var videoURLS: [String]?
    var playerViewModel = PlayerViewModel()
    
    
    private enum Section:Int {
        case main
    }
    
    private var videosDataSource:UICollectionViewDiffableDataSource<Section, VideoItem.ID>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureDataSource()
        setupVideosListner()
        loadVideoData()
        // Do any additional setup after loading the view.
        playSelectedVideo()
    }
    
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
    }
    
    func setupVideosListner() {
        playerViewModel.videos.sink { [unowned self] videoItems in
            self.loadVideoData()
        }.store(in: &cancelableObservers)
    }
    
    func reloadView() {
        self.collectionView.reloadData()
    }
    
    func loadVideoData() {
        let items = playerViewModel.videos.value
        let ids = items.map({$0.id})
        var snapshot = NSDiffableDataSourceSnapshot<Section, VideoItem.ID>()
        snapshot.appendSections([.main])
        snapshot.appendItems(ids, toSection: .main)
        videosDataSource.applySnapshotUsingReloadData(snapshot)
    }
    
    func playSelectedVideo() {
        let videos = self.playerViewModel.videos.value
        if let index = videos.firstIndex(where: { $0.id == self.playerViewModel.playingVideoID.value }) {
            collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .top, animated: false)
        }
        
    }
    
    private func configureDataSource() {
        let nib = UINib(nibName: String.init(describing: PlayerCell.self), bundle: .main)
        let videoCellRegisteration = UICollectionView.CellRegistration<PlayerCell, VideoItem>(cellNib: nib) { cell, indexPath, videoItem in
            cell.configure(videoItem)
        }
        
        videosDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [unowned self] collectionView, indexPath, itemIdentifier in
            let item = self.playerViewModel.videos.value.filter({ $0.id == itemIdentifier }).first
            return collectionView.dequeueConfiguredReusableCell(using: videoCellRegisteration, for: indexPath, item: item)
        })
    }
    
    deinit {
        print("not removing")
    }
}

extension PlayerViewController {
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal

        let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
        return layout
    }
}
extension PlayerViewController:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let tempCell = cell as? PlayerCell else {
            return
        }
        tempCell.cellDisappeared()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let tempCell = cell as? PlayerCell else {
            return
        }
        tempCell.playerView.playVideo()
    }
    
    
}
