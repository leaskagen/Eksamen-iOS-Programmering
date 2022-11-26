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
    
    var fruitEaten = [FruitsEaten]()
    var dates = [Date]()
    var formattedDates = [String]()
    let formatter = DateFormatter()
    
    @IBOutlet weak var logTableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Connect to core data
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        let moc = container.viewContext
        // Fetch all eaten fruits from core data
        let fetchRequest: NSFetchRequest<FruitsEaten>
        fetchRequest = FruitsEaten.fetchRequest()
        fruitEaten = try! moc.fetch(fetchRequest)
        
        // Append all dates to array
        fruitEaten.forEach { EatenFruit in
            dates.append(EatenFruit.date!)
        }

        // Sort dates in ascending order
        dates.sort(){$0 < $1}
        
        // Format each date to string format
        // example "mandag 1. januar 2022"
        formatter.dateStyle = .full
        dates.forEach{
            date in
            let formattedDate = formatter.string(from: date)
            if (!formattedDates.contains(formattedDate)) {
                formattedDates.append(formattedDate)
            }
        }
        
        // Table view
        logTableView.dataSource = self
        logTableView.delegate = self
        
        // Make footers not stick to bottom
        logTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -75, right: 0)
    }
}

extension LogListViewController : UITableViewDataSource {
    
    // One section of fruits for each date
    func numberOfSections(in tableView: UITableView) -> Int {
        return formattedDates.count
    }
    
    // Amount of rows for each sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var fruitCount = 0
        
        // Amount of fruits for each date
        fruitEaten.forEach { FruitEaten in
            let formattedDate = formatter.string(from: FruitEaten.date!)
            if (formattedDate == formattedDates[section].description) {
                fruitCount += 1
            }
        }
        return fruitCount
    }
    
    // Header for each section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Create header view
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        header.backgroundColor =  UIColor(red: 0.7, green: 1, blue: 0.7, alpha: 1)
             
        // Create header label
        let headerLabel = UILabel(frame: CGRect(x: 15, y: -6, width: header.frame.width - 15, height: 40))
        headerLabel.font = UIFont.systemFont(ofSize: 20)
        // Header text is this section's date
        headerLabel.text = formattedDates[section].capitalized
        // Add header label to header
        header.addSubview(headerLabel)
        
        return header
    }
    
    // Footer for each section
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        var fruits = [FruitsEaten]()
        
        var carbohydrates: Double = 0
        var protein: Double = 0
        var fat: Double = 0
        var calories: Double = 0
        var sugar: Double = 0
        
        // Fruits eaten this day
        fruitEaten.forEach{ FruitEaten in
            let formattedDate = formatter.string(from: FruitEaten.date!)
            if (formattedDate == formattedDates[section]) {
                fruits.append(FruitEaten)
            }
        }
        
        // Sum the nutritions for all the fruits eaten this day
        fruits.forEach{ fruit in
            carbohydrates += fruit.carbohydrates
            protein += fruit.protein
            fat += fruit.fat
            calories += fruit.calories
            sugar += fruit.sugar
        }
        
        // Round off nutritions to 2 decimals
        carbohydrates = round(carbohydrates * 100) / 100.0
        protein = round(protein * 100) / 100.0
        fat = round(fat * 100) / 100.0
        calories = round(calories * 100) / 100.0
        sugar = round(sugar * 100) / 100.0
        
        // Create footer view
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 125))
        footerView.backgroundColor =  UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
          
        // Create footer label
        let footerLabel = UILabel(frame: CGRect(x: 10, y: -25, width: footerView.frame.width, height: 75))
        footerLabel.font = UIFont.systemFont(ofSize: 14)
        footerLabel.numberOfLines = 2
        // Footer text is all the nutritions summed
        footerLabel.text = "Carbohydrates: \(carbohydrates) Protein: \(protein) Fat: \(fat) Calories: \(calories) Sugar: \(sugar)"
        // Add footer label to footer
        footerView.addSubview(footerLabel)
        return footerView
    }
    
    // Table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = logTableView.dequeueReusableCell(withIdentifier: "LogCell", for: indexPath) as! LogListCell
        
        var fruits = [FruitsEaten]()
        
        // Fruits for this section's day
        fruitEaten.forEach { fruit in
            let formattedDate = formatter.string(from: fruit.date!)
            if (formattedDate == formattedDates[indexPath.section]) {
                fruits.append(fruit)
            }
        }
        
        // Fruit name
        cell.logCellLabel.text = fruits[indexPath.row].fruit
        return cell
    }
}

extension LogListViewController : UITableViewDelegate {
    
}
