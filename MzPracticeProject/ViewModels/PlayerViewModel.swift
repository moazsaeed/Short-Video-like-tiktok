//
//  PlayerViewModel.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 11/06/2022.
//

import Foundation
import Combine

class PlayerViewModel {
    
    var videos = CurrentValueSubject<[VideoItem], Never>([VideoItem]())
    var playingVideoID = CurrentValueSubject<UUID?, Never>(nil)
    
    lazy var cacheManager = CachePlayerManager.shared
    
    func cacheNextItemsFromIndex(_ index:Int) {
        let items = self.videos.value
        var i = 0
        while(i < 2) {
            let nextItemIndex = index + i
            if (nextItemIndex < items.count){
                let item = items[nextItemIndex]
                cacheManager.addCachePlayerFor(item)
            } else {
                break
            }
            i += 1
        }
    }
}
