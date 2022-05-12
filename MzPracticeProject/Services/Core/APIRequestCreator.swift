//
//  URLRequestConfigurator.swift
//  MzPracticeProject
//
//  Created by Moaz Saeed (c) on 10/05/2022.
//

import Foundation

public typealias HTTPParameters = [String: Any]
public typealias HTTPHeaders = [String: Any]
public typealias HTTPBody = [String: Any]

public enum HTTPMethod: String{
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

struct APIRequestCreator {
    
    static func createURLRequest(url: String,
                                    method: HTTPMethod,
                                    parameters: HTTPParameters?,
                                    headers: HTTPHeaders?,
                                    body: HTTPBody?) throws -> URLRequest {
        
        guard let requetURL = URL(string: url) else {
            fatalError("url creation failed")
        }
        
        var request = URLRequest.init(url: requetURL,
                                      cachePolicy: .reloadIgnoringLocalCacheData,
                                      timeoutInterval: APIConstants.requestTimeoutInterval)
        request.httpMethod = method.rawValue
        try configureParamterHeadersBody(parameters: parameters, headers: headers, body: body, request: &request)
        return request
        
    }
    
    static func configureParamterHeadersBody(parameters: HTTPParameters?,
                                            headers:HTTPHeaders?,
                                            body:HTTPBody?,
                                            request: inout URLRequest) throws {
        do {
            if let headers = headers {
                try URLEncoder.encodeHeaders(of: &request, headers: headers)
            }
            if let parameters = parameters {
                try URLEncoder.encodeParameters(of: &request, parameters: parameters)
            }
            if let body = body {
                try URLEncoder.encodeBody(of: &request, body: body)
            }
            
            
        } catch {
            throw APIError.encodingFailed
        }
    }
    
}

struct URLEncoder {
    static func encodeParameters(of request: inout URLRequest, parameters:HTTPParameters) throws {
        guard let url = request.url else {
            throw APIError.missingURL
        }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            request.url = urlComponents.url
        }
        
    }
    
    
    static func encodeHeaders(of request: inout URLRequest, headers:HTTPHeaders) throws {
        
        for (key, value) in headers {
            if let value = value as? String {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
    }
    
    static func encodeBody(of request: inout URLRequest, body:HTTPBody) throws {
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
    }
}

struct APIResponse {
    
    // Properly checks and handles the status code of the response
    static func handleNetworkResponse(for response: HTTPURLResponse?) -> Result<String, Error>{
        
        guard let res = response else { return Result.failure(APIError.UnwrappingError)}
        
        switch res.statusCode {
        case 200...299: return .success(APIError.success.rawValue)
        case 401: return .failure(APIError.authenticationError)
        case 400...499: return .failure(APIError.badRequest)
        case 500...599: return .failure(APIError.serverSideError)
        default: return .failure(APIError.failed)
        }
    }
    
}
