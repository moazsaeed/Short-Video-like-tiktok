//
//  NewsAPI.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 12/05/2022.
//

import Foundation

struct NewsAPI: APIDataProtocol {
    var path: String {
        return APIRoutes.news.rawValue
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
