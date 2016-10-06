//
//  DataController.swift
//  NebulaSampleApplication
//
//  Created by Craig Barreras on 10/6/16.
//  Copyright © 2016 Vicino. All rights reserved.
//

import UIKit
import CoreData
import Nebula

class DataController: NSPersistentContainer {
    let nebula = Nebula()
    
    func getFakeJSON() {
        let requestProvider = URLRequestProvider(urlString: "https://jsonplaceholder.typicode.com/posts")
        let getDataTask = NetworkOperationSource(urlRequest: requestProvider.getRequest()!)
        let saveOperation = SaveEntitiesOperation(moc: newBackgroundContext())
        nebula.startWorkflow(tasks: [getDataTask, ParseOperation(), saveOperation])
    }
}
