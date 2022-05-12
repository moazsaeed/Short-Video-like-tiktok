//
//  ServiceClient.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 10/05/2022.
//

import Foundation

protocol APIClientProtocol {
    func fetch<T: Codable>(of Type: T.Type,api:APIDataProtocol, _ completion: @escaping (Result<T, Error>) -> () )
}

class APIClient: APIClientProtocol {
    
    private let urlSession = URLSession.shared
    
    func fetch<T: Codable>(of Type: T.Type,api:APIDataProtocol, _ completion: @escaping (Result<T, Error>) -> () ) {
        
        //let baseURL = URL(string: APIConstants.API_BASE_URL) (APIRoutes.news
        
        let url = api.baseURL + api.path
        do {
            let request = try APIRequestCreator.createURLRequest(url: url,
                                                                 method: api.method,
                                                                 parameters: api.parameteres,
                                                                 headers: api.headers,
                                                                 body: api.body)
            urlSession.dataTask(with: request) {  responseData, urlResponse, error in
                
                if let response = urlResponse as? HTTPURLResponse, let data = responseData {
                    
                    let responseResult = APIResponse.handleNetworkResponse(for: response)
                    switch responseResult {
                    case .success:
                        do {
                            let decodedData = try JSONDecoder().decode(T.self, from: data)
                            completion(Result.success(decodedData))
                        } catch {
                            completion(Result.failure(APIError.parsingFailed))
                        }
                    case .failure(let err):
                        completion(Result.failure(err))
                    }
                } else if let error = error {
                    completion(Result.failure(error))
                }
            }.resume()
            
        } catch {
            completion(Result.failure(APIError.badRequest))
        }
        
        
        
        
    }
    
    
    
}





