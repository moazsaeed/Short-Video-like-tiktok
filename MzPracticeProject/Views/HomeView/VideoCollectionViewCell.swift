//
//  VideoCollectionViewCell.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 10/06/2022.
//

import UIKit
import Kingfisher

class VideoCollectionViewCell: UICollectionViewCell {
    static let identifier = "VideoCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    var videoItem:VideoItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .lightGray
    }
    
    func setupCellWith(videoItem: VideoItem?) {
        guard let item = videoItem else {
            return
        }
        self.imageView.kf.setImage(with: URL(string: item.thumbnailURL))
    }
    
    func setupCellWith(_ imageURlString:String) {
        self.imageView.kf.setImage(with: URL(string: imageURlString))
    }
    
    
    

}
