//
//  MZPlayer.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 13/06/2022.
//

import Foundation
import AVFoundation

class CachePlayer {
    
    var videoItem:VideoItem?
    private var videoURL:String?
    private var thumbnailUrlString:String?
    private var asset: AVURLAsset?
    private var playerItem: AVPlayerItem?
    var player:AVQueuePlayer?
    private var playerlooper:AVPlayerLooper?
//    private var avPlayerLayer: AVPlayerLayer?
    
    init(item:VideoItem) {
        configurePlayer(item: item)
    }
    
    private func configurePlayer(item:VideoItem) {
        if self.videoItem?.id != item.id {
            clearPlayer()
        }
        self.videoItem = item
        videoURL = videoItem?.videoURL
        thumbnailUrlString = videoItem?.thumbnailURL
        if let urlString = videoURL, let url = URL(string: urlString) {
            self.asset = AVURLAsset(url: url)
            self.playerItem = AVPlayerItem(asset: asset!)
            self.playerItem?.preferredForwardBufferDuration = 1
            if player == nil {
                player = AVQueuePlayer(playerItem: playerItem)
                
                playerlooper = AVPlayerLooper(player: player!, templateItem: playerItem!)
//                avPlayerLayer = AVPlayerLayer(player: player)
//                avPlayerLayer?.videoGravity = .resizeAspectFill
            } else {
                player?.replaceCurrentItem(with: playerItem)
            }
        }
        
    }
    
    func clearPlayer() {
        
        videoItem = nil
        thumbnailUrlString = nil
        videoURL = nil
        asset = nil
        playerItem = nil
        player = nil
        playerlooper = nil
    }
}
