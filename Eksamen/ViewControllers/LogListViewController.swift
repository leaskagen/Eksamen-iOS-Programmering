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
    
    var fruitEaten = [FruitEaten]()
    
    var dates = [String]()
    
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
        
        let fetchRequest: NSFetchRequest<FruitEaten>
        fetchRequest = FruitEaten.fetchRequest()
        
        
        
        fruitEaten = try! moc.fetch(fetchRequest)
        
        fruitEaten.forEach { EatenFruit in
            if (!dates.contains(EatenFruit.date!)) {
                dates.append(EatenFruit.date!)
            }
        }
        
        print(dates)
        
        logTableView.dataSource = self
        logTableView.delegate = self
    }
}

extension LogListViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dates.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var fruitCount = 0
        fruitEaten.forEach { FruitEaten in
            if (FruitEaten.date == dates[section]) {
                fruitCount += 1
            }
        }
        return fruitCount
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor =  UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
             
        let lbl = UILabel(frame: CGRect(x: 15, y: -6, width: view.frame.width - 15, height: 40))
           lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.text = fruitEaten[section].date
           view.addSubview(lbl)
           return view
         }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        var fruits = [FruitEaten]()
        
        var carbohydrates: Double = 0
        var protein: Double = 0
        var fat: Double = 0
        var calories: Double = 0
        var sugar: Double = 0
        
        fruitEaten.forEach{ FruitEaten in
            if (FruitEaten.date == fruitEaten[section].date) {
                fruits.append(FruitEaten)
            }
        }
        
        fruits.forEach{ fruit in
            carbohydrates += fruit.carbohydrates
            protein += fruit.protein
            fat += fruit.fat
            calories += fruit.calories
            sugar += fruit.sugar
        }
        
        carbohydrates = round(carbohydrates * 100) / 100.0
        protein = round(protein * 100) / 100.0
        fat = round(fat * 100) / 100.0
        calories = round(calories * 100) / 100.0
        sugar = round(sugar * 100) / 100.0
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 125))
        view.backgroundColor =  UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
          
        let lbl = UILabel(frame: CGRect(x: 10, y: -25, width: view.frame.width - 15, height: 75))
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 2
     lbl.text = "Carbohydrates: \(carbohydrates) Protein: \(protein) Fat: \(fat) Calories: \(calories) Sugar: \(sugar)"
        view.addSubview(lbl)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = logTableView.dequeueReusableCell(withIdentifier: "LogCell", for: indexPath) as! LogListCell
        
        var fruits = [FruitEaten]()
        
        fruitEaten.forEach { fruit in
            if (fruit.date == fruitEaten[indexPath.section].date) {
                fruits.append(fruit)
            }
        }
        
        //let fruit = fruits.(fruits.date == indexPath.section)
        
        print(fruits)
        
        cell.logCellLabel.text = fruits[indexPath.row].fruit
        return cell
    }
    
    
}

extension LogListViewController : UITableViewDelegate {
    
}

