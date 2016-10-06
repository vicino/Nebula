//
//  NetworkOperationDataProvider.swift
//  AriesiOS
//
//  Created by Craig Barreras on 8/13/16.
//  Copyright © 2016 Vicino. All rights reserved.
//

import Foundation

public protocol DataProviderProtocol {
    func getData()
    weak var delegate: DataProviderDelegate? { get set }
}

public protocol DataProviderDelegate: class {
    func dataProvider(provider: DataProviderProtocol, didFinishWith error: Error?, data: Data?)
}

public class NetworkDataProvider: NSObject, DataProviderProtocol {
    
    public weak var delegate: DataProviderDelegate?
    
    private var localURLSession: URLSession {
        return URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }
    
    var data = Data()
    let request: URLRequest
    
    public init(request: URLRequest) {
        self.request = request
    }
    
    public func getData() {
        let task = localURLSession.dataTask(with: request)
        task.resume()
        NetworkObserver.startObserving()
    }
}

extension NetworkDataProvider: URLSessionDataDelegate {
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        session.finishTasksAndInvalidate()
        delegate?.dataProvider(provider: self, didFinishWith: error, data: data)
        NetworkObserver.stopObserving()
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.data.append(data)
    }
}
