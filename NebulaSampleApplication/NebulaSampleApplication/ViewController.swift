//
//  ViewController.swift
//  NebulaSampleApplication
//
//  Created by Craig Barreras on 10/6/16.
//  Copyright © 2016 Vicino. All rights reserved.
//

import UIKit
import CoreData

private let ReuseIdentifier = "Cell"

class ViewController: UIViewController {
    
    fileprivate var frc: NSFetchedResultsController<MyEntity>!
    
    weak var dataController: DataController!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<MyEntity> = NSFetchRequest(entityName: "MyEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch { }
        
        dataController.getFakeJSON()
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return frc.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frc.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier, for: indexPath)
        let entity = frc.object(at: indexPath)
        
        cell.textLabel?.text = entity.title
        cell.detailTextLabel?.text = entity.body
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {}

extension ViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
