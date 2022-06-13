//
//  VideoPlayer.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 11/06/2022.
//

import Foundation
import UIKit
import AVFoundation
import Combine

enum PlayerState {
    case play
    case pause
}


class VideoPlayer: UIView {
    
    private var videoURL:String?
    private var asset: AVURLAsset?
    private var playerItem: AVPlayerItem?
    private var player:AVQueuePlayer?
    private var playerlooper:AVPlayerLooper?
    private var avPlayerLayer: AVPlayerLayer?
    var observer: NSKeyValueObservation?
    private var containerView:UIView!
    
    private var isLoading = CurrentValueSubject<Bool, Never>(false)
    
    private var subscribers = Set<AnyCancellable>()
    
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var playerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        loadNib()
        setupBtn()
        configureListener()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avPlayerLayer?.frame = self.layer.bounds
    }
    
    func getPlayer() -> AVQueuePlayer? {
        return player
    }
    
    
    func configurePlayer(urlString:String) {
        self.videoURL = urlString
        configurePlayer()
        self.bringSubviewToFront(playPauseBtn)
    }
    
    func configureListener() {
        isLoading.sink { isLoadingTemp in
            if isLoadingTemp == true {
                self.showLoading()
            } else {
                self.hideLoading()
            }
        }.store(in: &subscribers)
    }
    
    private func configurePlayer() {
        
        if let urlString = videoURL, let url = URL(string: urlString) {
            isLoading.send(true)
            self.asset = AVURLAsset(url: url)
            self.playerItem = AVPlayerItem(asset: asset!)
            if player == nil {
                player = AVQueuePlayer(playerItem: playerItem)
                addObserverToPlayerItem()
//                player?.addObserver(self, forKeyPath: "status", options: [], context: nil)
                playerlooper = AVPlayerLooper(player: player!, templateItem: playerItem!)
                
                avPlayerLayer = AVPlayerLayer(player: player)
                avPlayerLayer?.videoGravity = .resizeAspectFill
                
//                playerView.layer.sublayers?
//                    .filter {$0 is AVPlayerLayer}
//                    .forEach { $0.removeFromSuperlayer() }
                
                playerView.layer.addSublayer(avPlayerLayer!)
            } else {
                player?.replaceCurrentItem(with: playerItem)
            }
            
//            self.playVideo()
            
            
        }
        
    }
    
    @IBAction func playPauseBtn(_ sender: Any) {
        if player?.timeControlStatus == .playing {
            pausePressed()
        } else if player?.timeControlStatus == .paused {
            playPressed()
        }
    }
    
    func pausePressed() {
        pauseVideo()
        self.setBtnFor(.pause)
    }
    
    func playPressed() {
        playVideo()
        self.setBtnFor(.play)
    }
    
    func setBtnFor(_ state:PlayerState ) {
        switch state {
        case .play:
            playPauseBtn.isSelected = false
            
        case .pause:
            playPauseBtn.isSelected = true
        }
    }
    
    func setupBtn() {
        playPauseBtn.setImage(UIImage(systemName: "play.fill"), for: .selected)
        playPauseBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    
    func loadNib() {
        let name = String.init(describing: VideoPlayer.self)
        containerView = Bundle.main.loadNibNamed(name,
                                               owner: self,
                                                 options: nil)!.first as? UIView
        containerView.frame = self.frame
        self.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    func stopVideo() {
//        print("///-=-=-=-=-=-=---=-=-=-=-=-=-=-")
        print("///player sstopped =  \(videoURL ?? "")")
//        print("///-=-=-=-=-=-=---=-=-=-=-=-=-=-")
        player?.pause()
    }
    
    func pauseVideo() {
        player?.pause()
    }
    
    func playVideo() {
        player?.play()
//        print("///-=-=-=-=-=-=---=-=-=-=-=-=-=-")
        print("///player play =  \(videoURL ?? "")")
//        print("///-=-=-=-=-=-=---=-=-=-=-=-=-=-")
    }
    
    func clearPlayer() {
        
        removeObserver()
        
        videoURL = nil
        asset = nil
        playerItem = nil
        player = nil
        playerlooper = nil
        avPlayerLayer = nil
        
    }
    
    deinit {
        self.removeObserver()
    }
}

extension VideoPlayer {
    func removeObserver() {
        if let observer = observer {
            observer.invalidate()
        }
    }
    
    fileprivate func addObserverToPlayerItem() {
        self.observer = player?.observe(\.status, options: [.initial, .new], changeHandler: { [unowned self]  item, _ in
            let status = item.status
            switch status {
            case .readyToPlay:
                isLoading.send(false)
                print("Status: readyToPlay")
            case .failed:
                isLoading.send(false)
                self.pausePressed()
                print("Status: failed Error: " + item.error!.localizedDescription )
            case .unknown:
                print("Status: unknown")
            @unknown default:
                self.pausePressed()
            }
        })
    }
}
