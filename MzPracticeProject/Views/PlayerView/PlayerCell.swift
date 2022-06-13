//
//  PlayerCellCollectionViewCell.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 11/06/2022.
//

import UIKit



class PlayerCell: UICollectionViewCell {
    
    @IBOutlet weak var playerView: VideoPlayer!
    var currentVideoItem:VideoItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ cachePlayer:CachePlayer) {
        self.currentVideoItem = cachePlayer.videoItem
        playerView.configurePlayerWith(cachePlayer: cachePlayer)
    }
    
    func cellDisappeared() {
        playerView.stopVideo()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerView.clearPlayer()
    }
    
    
}
