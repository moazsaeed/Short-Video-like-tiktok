//
//  ServiceClient.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 10/06/2022.
//

import Foundation
import Combine

protocol APIClientProtocol {
    
    // to request data with only combine.
    func fetch<T: Decodable>(_ type:T.Type, api: APIDataProtocol) -> AnyPublisher<T, Error>
}

class APIClient: APIClientProtocol {
    
    
    func fetch<T: Decodable>(_ type:T.Type, api: APIDataProtocol) -> AnyPublisher<T, Error> {
        let url = api.baseURL + api.path
        do {
            let request = try APIRequestCreator.createURLRequest(url: url,
                                                                 method: api.method,
                                                                 parameters: api.parameteres,
                                                                 headers: api.headers,
                                                                 body: api.body)
            return fetch(type, request: request)
        } catch {
            return Fail(error: APIError.badRequest).eraseToAnyPublisher()
        }
    }
    
    private func fetch<T: Decodable>(_ type:T.Type, request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { element -> Data in
                if let response = element.response as? HTTPURLResponse {
                    let responseStatus =  APIResponse.handleNetworkResponse(for: response)
                    switch responseStatus {
                    case .success:
                        return element.data
                    case .failure(let err):
                        throw err
                    }
                } else {
                    throw APIError.badResponse
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}





