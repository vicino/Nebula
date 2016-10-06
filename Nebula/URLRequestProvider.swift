//
//  URLRequestProvider.swift
//  AriesiOS
//
//  Created by Craig Barreras on 8/13/16.
//  Copyright © 2016 Vicino. All rights reserved.
//

import Foundation

public protocol URLRequestProviderProtocol {
    func getRequest() -> URLRequest?
}

public struct URLRequestProvider: URLRequestProviderProtocol {
    let urlString: String
    let queryItems: [URLQueryItem]?
    let httpRequestMethod: HTTPRequestMethod
    let headers: [HTTPRequestHeader]?
    let body: Any?
    
    public init(
        urlString: String,
        queryItems: [URLQueryItem]? = nil,
        httpRequestMethod: HTTPRequestMethod = .GET,
        headers: [HTTPRequestHeader]? = nil,
        body: Any? = nil) {
        self.urlString = urlString
        self.queryItems = queryItems
        self.httpRequestMethod = httpRequestMethod
        self.headers = headers
        self.body = body
    }
    
    public func getRequest() -> URLRequest? {
        guard var urlComponents = URLComponents(string: urlString) else {
            return nil
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        return URLRequest(url: url)
            .setUrlRequestMethod(method: httpRequestMethod)
            .setRequestHeaders(headers: headers)
            .setRequestBody(body: body)
    }
}

extension URLRequest {
    @discardableResult
    func setUrlRequestMethod(method: HTTPRequestMethod) -> URLRequest {
        var request = self
        request.httpMethod = method.rawValue
        return request
    }
    
    @discardableResult
    func setRequestHeaders(headers: [HTTPRequestHeader]?) -> URLRequest {
        var request = self
        // add any supplied request headers
        if let headers = headers {
            for header in headers {
                request.addValue(header.value, forHTTPHeaderField: header.field)
            }
        }
        
        return request
    }
    
    @discardableResult
    func setRequestBody(body: Any?) -> URLRequest {
        var request = self
        if let requestBody = body {
            do {
                let body = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
                request.httpBody = body
            } catch { }
        }
        
        return request
    }
}
