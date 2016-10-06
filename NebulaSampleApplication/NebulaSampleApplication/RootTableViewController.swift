//
//  RootTableViewController.swift
//  NebulaSampleApplication
//
//  Created by Craig Barreras on 10/6/16.
//  Copyright © 2016 Vicino. All rights reserved.
//

import UIKit

class RootTableViewController: UITableViewController {

    weak var dataController: DataController!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case "CoreData":
            let destination = segue.destination as! ViewController
            destination.dataController = dataController
        case "Callback":
            let destination = segue.destination as! CallbackTableViewController
            destination.dataController = dataController
        default:
            break
        }
    }
}
