//
//  ViewController.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 08/06/2022.
//

import UIKit
import Combine



class HomeViewController: UIViewController {
    
    var cancelableObservers:[AnyCancellable] = []
    var videoURLS: [String]?
    var homeViewModel = HomeViewModel()
    
    private enum Section:Int {
        case grid
    }
    
    private var videosDataSource:UICollectionViewDiffableDataSource<Section, VideoItem.ID>!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
        configureDataSource()
        setupVideosListner()
        loadVideos()
        loadVideoData()
        
    }
    
    func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
//        collectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: true)
    }
    
    func loadVideoData() {
        let items = homeViewModel.videos.value
        let ids = items.map({$0.id})
        var snapshot = NSDiffableDataSourceSnapshot<Section, VideoItem.ID>()
        snapshot.appendSections([.grid])
        snapshot.appendItems(ids, toSection: .grid)
        videosDataSource.applySnapshotUsingReloadData(snapshot)
    }
    
    func loadVideos() {
        
        homeViewModel.fetchVideoItems()
    }
    
    func reloadView() {
        self.collectionView.reloadData()
    }
    
    func setupVideosListner() {
        homeViewModel.videos.sink { [unowned self] videoItems in
//            self.collectionView.reloadData()
            self.loadVideoData()
        }.store(in: &cancelableObservers)
    }
    
    private func configureDataSource() {
        let nib = UINib(nibName: String.init(describing: VideoCollectionViewCell.self), bundle: .main)
        let videoCellRegisteration = UICollectionView.CellRegistration<VideoCollectionViewCell, VideoItem>(cellNib: nib) { cell, indexPath, videoItem in
            cell.setupCellWith(videoItem: videoItem)
        }
        
        videosDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [unowned self] collectionView, indexPath, itemIdentifier in
            let item = self.homeViewModel.videos.value.filter({ $0.id == itemIdentifier }).first
            return collectionView.dequeueConfiguredReusableCell(using: videoCellRegisteration, for: indexPath, item: item)
        })
    }

}

extension HomeViewController {
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        
        let playerVC = PlayerViewController.instanceFromStoryboard()
        let videosTemp = homeViewModel.videos.value
        playerVC.playerViewModel.videos.value = videosTemp
        let selectedVideo = videosTemp[indexPath.item]
        playerVC.playerViewModel.playingVideoID.value = selectedVideo.id
//        navigationController?.pushViewController(playerVC, animated: true)
//        navigationController?.present(playerVC, animated: true)
        navigationController?.show(playerVC, sender: self)
        
    }
}
