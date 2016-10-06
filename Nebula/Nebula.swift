//
//  Nebula.swift
//  Aries-iOS
//
//  Created by Craig Barreras on 8/13/16.
//  Copyright © 2016 Vicino. All rights reserved.
//

import UIKit

class NebulaAdapterOperation: Operation {
    let task1: NebulaOperation
    let task2: NebulaOperation
    
    init(task1: NebulaOperation, task2: NebulaOperation) {
        self.task1 = task1
        self.task2 = task2
    }
    
    override func main() {
        task2.input = task1.output
    }
}

public class Nebula: OperationQueue {
    public func startWorkflow(tasks: [NebulaOperation]) {
        if tasks.count > 1 {
            for idx in 0...tasks.count - 1 {
                if idx == tasks.count - 1 {
                    let task = tasks[idx]
                    addOperation(task)
                    return
                }
                
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
}
