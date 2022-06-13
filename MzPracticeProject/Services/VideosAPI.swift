//
//  VideosAPI.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 08/06/2022.
//

import Foundation

struct VideosAPI: APIDataProtocol {
    var path: String {
        return APIRoutes.videos.rawValue
    }
    
    var parameteres: HTTPParameters? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var body: HTTPBody? {
        return nil
    }
}
