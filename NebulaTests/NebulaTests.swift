//
//  NebulaTests.swift
//  NebulaTests
//
//  Created by Craig Barreras on 8/14/16.
//  Copyright © 2016 Vicino. All rights reserved.
//

import XCTest
@testable import Nebula

class LogOperation: NebulaOperation {
    override func main() {
        print(input)
    }
}

class NebulaTests: XCTestCase {
    
    var nebula: Nebula!
    
    override func setUp() {
        super.setUp()
        nebula = Nebula()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNetworkOperation() {
        let networkExpectation = expectation(description: "NetworkRequest")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let request = URLRequest(url: url)
        let networkOperation = NetworkOperationSource(urlRequest: request)
        let parseOperation = ParseOperation()
        let logOperation = LogOperation()
        logOperation.completionBlock = {
            networkExpectation.fulfill()
        }
        
        nebula.startWorkflow(tasks: [networkOperation, parseOperation, logOperation])
        
        waitForExpectations(timeout: 5) { (error) in
            print("finished")
        }
    }
}
