//
//  SaveEntitiesOperation.swift
//  NebulaSampleApplication
//
//  Created by Craig Barreras on 10/6/16.
//  Copyright © 2016 Vicino. All rights reserved.
//

import UIKit
import Nebula
import CoreData

class SaveEntitiesOperation: NebulaOperation {
    
    let moc: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
        super.init()
    }
    
    override func main() {
        guard let input = input as? [JSON] else {
            print("encountered error")
            return
        }
        
        for json in input {
            print(json)
            let entity = MyEntity(context: moc)
            entity.title = json["title"] as? String
            entity.body = json["body"] as? String
            entity.userId = json["userId"] as? Int16 ?? 0
            entity.id = json["id"] as? Int16 ?? 0
            print(entity)
        }
        
        do {
            try moc.save()
        } catch {
            print("Error saving context")
        }
    }
}
