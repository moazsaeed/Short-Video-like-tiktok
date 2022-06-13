//
//  HomeViewModel.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 10/06/2022.
//

import Foundation
import Combine


class HomeViewModel {
    
    var videos = CurrentValueSubject<[VideoItem], Never>([VideoItem]())
    
    var cancelableObservers:[AnyCancellable] = []
    
    func fetchVideoItems() {
        let videosAPI = VideosAPI()
        let apiclient = APIClient()
        
        apiclient.fetch(HlsVideos.self, api: videosAPI)
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] completion in
                print("result = \(completion)")
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("eror: \(error)")
                    self.videos.send([VideoItem]())
                }
            } receiveValue: { [unowned self] hlsVideos in
                self.videos.send(self.mapToVideoItems(hlsVideos))
            }.store(in: &cancelableObservers)
    }
    
    func mapToVideoItems(_ videos:HlsVideos) -> [VideoItem] {
        
        guard let videoUrls = videos.videoUrls, let thumbnailUrls = videos.thumbnailUrls else {
            return [VideoItem]()
        }
        return Array(zip(videoUrls, thumbnailUrls)).map ({ VideoItem($0.0, $0.1) })
    }
    
}

