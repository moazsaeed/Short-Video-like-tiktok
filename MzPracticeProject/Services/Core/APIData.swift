//
//  APIData.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 10/05/2022.
//

import Foundation


protocol APIDataProtocol {
    
    var baseURL: String { get }
    
    var path: String { get }
    
    var parameteres: HTTPParameters?{ get }
    
    var headers: HTTPHeaders? { get }
    
    var method: HTTPMethod { get }
    
    var body: HTTPBody? { get }
    
    init (parameters: HTTPParameters?)
    
}

extension APIDataProtocol {
    
    
    var baseURL: String {
        return APIConstants.API_BASE_URL
    }
    //mixin
    init (parameters: HTTPParameters? = nil) {
        self.init(parameters: parameters)
    }
}


