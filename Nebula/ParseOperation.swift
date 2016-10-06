//
//  ParseOperation.swift
//  Vicino
//
//  Created by Alois Barreras on 6/28/16.
//  Copyright © 2016 Vicino. All rights reserved.
//

import Foundation
import CoreData

public class ParseOperation<T>: Operation {
    
    private var _finished = false
    final override public var isFinished: Bool {
        get {
            return _finished
        }
        set {
            willChangeValue(forKey: "isFinished")
            _finished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    
    private var _executing = false
    final override public var isExecuting: Bool {
        get {
            return _executing
        }
        set {
            willChangeValue(forKey: "isExecuting")
            _executing = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    final public var data: Data?
    final public var error: NSError?
    final public var httpResponse: HTTPURLResponse?
    final public var json: T!
    
    final override public func start() {
        defer {
            isExecuting = false
            isFinished = true
        }
        
        if let _ = error {
            
        }
        
        guard !isCancelled, let data = data else {
            return
        }
        
        do {
            let parsedData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0))
            json = parsedData as! T
        } catch {
            
        }
        
        isExecuting = true
        main()
    }
}
