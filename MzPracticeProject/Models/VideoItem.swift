//
//  VideoItem.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 10/06/2022.
//

import Foundation

struct VideoItem: Identifiable {
    let id = UUID()
    var videoURL:String
    var thumbnailURL:String
    
    init(_ videoURL:String, _ thumbnailURL:String) {
        self.videoURL = videoURL
        self.thumbnailURL = thumbnailURL
    }
}
