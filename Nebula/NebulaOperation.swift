//
//  NebulaOperation.swift
//  Aries-iOS
//
//  Created by Craig Barreras on 8/13/16.
//  Copyright © 2016 Vicino. All rights reserved.
//

import UIKit

open class NebulaOperation: Operation {
    private var _isFinished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    open override var isFinished: Bool {
        get {
            return _isFinished
        }
    }
    
    private var _isExecuting = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    open override var isExecuting: Bool {
        get {
            return _isExecuting
        }
    }
    
    public var isAsync = false
    
    public var output: Any?
    public var input: Any?
    
    open override func start() {
        if isCancelled {
            finish()
            return
        }
        
        _isExecuting = true
        main()
        if !isAsync {
            finish()
        }
    }
    
    public func finish() {
        _isExecuting = false
        _isFinished = true
    }
}
