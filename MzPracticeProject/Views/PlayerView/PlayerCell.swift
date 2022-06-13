//
//  PlayerCellCollectionViewCell.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 11/06/2022.
//

import UIKit



class PlayerCell: UICollectionViewCell {
//    var playerView:VideoPlayer?
    
    
    @IBOutlet weak var playerView: VideoPlayer!
    var currentVideoItem:VideoItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ videoItem:VideoItem) {
        self.currentVideoItem = videoItem
        if let url = currentVideoItem?.videoURL {
            playerView.configurePlayer(urlString: url)
        }
        
    }
    
    func cellDisappeared() {
        playerView.stopVideo()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerView.clearPlayer()
    }
    
    
}
