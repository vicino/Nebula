//
//  NetworkOperationSource.swift
//  Nebula
//
//  Created by Craig Barreras on 8/15/16.
//  Copyright © 2016 Vicino. All rights reserved.
//

import UIKit

public class NetworkOperationSource: NebulaOperation {
    var dataProvider: DataProviderProtocol!
    let request: URLRequest
    
    public init(urlRequest: URLRequest) {
        self.request = urlRequest
        super.init()
        isAsync = true
    }
    
    override public func main() {
        dataProvider = NetworkDataProvider(request: request)
        dataProvider.delegate = self
        dataProvider.getData()
    }
}

extension NetworkOperationSource: DataProviderDelegate {
    public func dataProvider(provider: DataProviderProtocol, didFinishWith error: Error?, data: Data?) {
        output = data
        finish()
    }
}
