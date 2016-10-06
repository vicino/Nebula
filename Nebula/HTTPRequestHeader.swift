//
//  HTTPRequestHeader.swift
//  Vicino
//
//  Created by Alois Barreras on 6/28/16.
//  Copyright © 2016 Vicino. All rights reserved.
//

import Foundation

public protocol HTTPRequestHeader {
    var value: String { get set }
    var field: String { get set }
}

public struct ContentTypeHeader: HTTPRequestHeader {
    public enum ContentType: String {
        case ApplicationJSON = "application/json"
    }
    
    public var value: String
    public var field: String = "Content-Type"
    
    public init(contentType: ContentType) {
        value = contentType.rawValue
    }
}

public struct AuthorizationHeader: HTTPRequestHeader {
    public var value: String
    public var field: String = "Authorization"
    
    public init(value: String) {
        self.value = value
    }
}

public struct AcceptHeader: HTTPRequestHeader {
    public var value: String
    public var field: String = "Accept"
    
    public init(value: String) {
        self.value = value
    }
}

public struct CustomHeader: HTTPRequestHeader {
    public var value: String
    public var field: String
    
    public init(field: String, value: String) {
        self.field = field
        self.value = value
    }
}
