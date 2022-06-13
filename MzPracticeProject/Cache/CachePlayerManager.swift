//
//  CachePlayerManager.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 13/06/2022.
//

import Foundation

protocol CachePlayerManagerProtocol {
    
    func addIfAvailableGetCachedPlayerFor(_ videoItem:VideoItem ) -> CachePlayer
    func getCachePlayerFor(_ videoItem:VideoItem ) -> CachePlayer?
    func addCachePlayerFor(_ videoItem:VideoItem )
    func clearCache()
}

class CachePlayerManager:CachePlayerManagerProtocol {
    
    static let shared = CachePlayerManager()
    
    private init() { }
    
    private var maxLimit = 5
    
    private var playersQueue:[CachePlayer]?
    
    private func add(_ cachePlayer:CachePlayer ) {
        if playersQueue == nil {
            playersQueue = [cachePlayer]
        } else {
            if playersQueue!.count >= 5 {
                deque()
            }
            playersQueue?.append(cachePlayer)
        }
    }
    
    private func deque() {
        if playersQueue != nil {
            let removedPlayer = playersQueue?.removeFirst()
            removedPlayer?.clearPlayer()
        }
    }
    
    func addIfAvailableGetCachedPlayerFor(_ videoItem:VideoItem ) -> CachePlayer {
        if let playerTemp = getCachePlayerFor(videoItem) {
            return playerTemp
        } else {
            let playerTemp = CachePlayer(item: videoItem)
            add(playerTemp)
            return playerTemp
        }
    }
    
    func addCachePlayerFor(_ videoItem:VideoItem ) {
        if getCachePlayerFor(videoItem) != nil {
            return
        } else {
            let playerTemp = CachePlayer(item: videoItem)
            add(playerTemp)
        }
    }
    
    func getCachePlayerFor(_ videoItem:VideoItem ) -> CachePlayer? {
        return playersQueue?.filter( { $0.videoItem?.id == videoItem.id }).first
    }
    
    func clearCache() {
        self.playersQueue?.forEach({ cachedPlayer in
            cachedPlayer.clearPlayer()
        })
        self.playersQueue = nil
    }
}
