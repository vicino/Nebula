//
//  Nebula.swift
//  Aries-iOS
//
//  Created by Craig Barreras on 8/13/16.
//  Copyright © 2016 Vicino. All rights reserved.
//

import UIKit

private class NebulaAdapterOperation: Operation {
    let task1: NebulaOperation
    let task2: NebulaOperation
    
    init(task1: NebulaOperation, task2: NebulaOperation) {
        self.task1 = task1
        self.task2 = task2
    }
    
    override func main() {
        // this is guaranteed to run after task1 completes, so the output should be there
        // inspiration from here: https://forums.developer.apple.com/thread/25761
        task2.input = task1.output
    }
}

public class Nebula: OperationQueue {
    public func startWorkflow(tasks: [NebulaOperation]) {
        for idx in 0...tasks.count - 1 {
            // if last task, add it and return. No need for an adapter because there is no next operation
            if idx == tasks.count - 1 {
                let task = tasks[idx]
                addOperation(task)
                return
            }
            
            // get the current and next task and use the adapter operation to pass data between them
            let task = tasks[idx]
            let nextTask = tasks[idx + 1]
            let adapter = NebulaAdapterOperation(task1: task, task2: nextTask)
            adapter.addDependency(task)
            nextTask.addDependency(adapter)
            addOperation(task)
            addOperation(adapter)
        }
    }
}
