//
//  CallbackTableViewController.swift
//  NebulaSampleApplication
//
//  Created by Craig Barreras on 10/6/16.
//  Copyright © 2016 Vicino. All rights reserved.
//

import UIKit
import Nebula

class CallbackTableViewController: UITableViewController {
    
    weak var dataController: DataController!
    
    var data = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
}
