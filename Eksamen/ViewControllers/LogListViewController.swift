//
//  LogListViewController.swift
//  Eksamen
//
//  Created by Lea Skagen on 23/11/2022.
//

import Foundation
import UIKit
import CoreData

class LogListCell : UITableViewCell {
    @IBOutlet weak var logCellLabel : UILabel!
}

class LogListViewController : UIViewController {
    
    let container = NSPersistentContainer(name: "Eksamen")
    
    var eatenFruits = [EatenFruit]()
    
    //@IBOutlet weak var logCellLabel : UILabel!
    @IBOutlet weak var logTableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        let moc = container.viewContext
        
        let fetchRequest: NSFetchRequest<EatenFruit>
        fetchRequest = EatenFruit.fetchRequest()
        
        eatenFruits = try! moc.fetch(fetchRequest)
        logTableView.dataSource = self
        logTableView.delegate = self
    }
}

extension LogListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eatenFruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = logTableView.dequeueReusableCell(withIdentifier: "LogCell", for: indexPath) as! LogListCell
        cell.logCellLabel.text = eatenFruits[indexPath.row].fruit
        return cell
    }
    
    
}

extension LogListViewController : UITableViewDelegate {
    
}

