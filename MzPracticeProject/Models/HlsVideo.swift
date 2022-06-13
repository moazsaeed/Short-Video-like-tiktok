//
//  Videos.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 08/06/2022.
//

import Foundation

struct HlsVideos: Decodable {
    var success: Bool?
    let exceptionData: String?
    let error: String?
    let userDisplayName: String?
    let errorCode: Int?
    let videoUrls: [String]?
    let thumbnailUrls: [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case success = "success"
        case exceptionData = "exceptionData"
        case error = "error"
        case userDisplayName = "userDisplayName"
        case errorCode = "errorCode"
        case videoUrls = "videoUrls"
        case thumbnailUrls = "thumbnailUrls"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        exceptionData = try values.decodeIfPresent(String.self, forKey: .exceptionData)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        userDisplayName = try values.decodeIfPresent(String.self, forKey: .userDisplayName)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        videoUrls = try values.decodeIfPresent([String].self, forKey: .videoUrls)
        thumbnailUrls = try values.decodeIfPresent([String].self, forKey: .thumbnailUrls)
    }
    
}
