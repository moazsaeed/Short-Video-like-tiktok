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
}
