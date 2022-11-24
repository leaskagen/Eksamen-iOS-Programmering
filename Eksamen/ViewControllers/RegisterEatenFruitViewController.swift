//
//  RegisterEatenFruitViewController.swift
//  Eksamen
//
//  Created by Lea Skagen on 23/11/2022.
//

import Foundation
import UIKit
import CoreData

class RegisterEatenFruitViewController : UIViewController {
    
    let container = NSPersistentContainer(name: "Eksamen")
    
    @IBOutlet weak var eatenFruitLabel : UILabel!
    @IBOutlet weak var datePicker : UIDatePicker!
    
    //var container: NSPersistentContainer!
    
    var fruitName: String?
    var fruitCarbohydrates: Double?
    var fruitProtein: Double?
    var fruitFat: Double?
    var fruitCalories: Double?
    var fruitSugar: Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eatenFruitLabel.text = "When did you eat \(fruitName!)?"
        
        
    }
    
    @IBAction func cancelledAction() {
        self.dismiss(animated: true, completion: nil)
    }
    //let moc = persistentContainer.viewContext
    @IBAction func saveEatenFruit() {
        
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
        
        let entity = NSEntityDescription.entity(forEntityName: "FruitEaten", in: moc)
        
        //var eatenFruit = EatenFruit(entity: entity!, insertInto: moc)
        
        //var eatenFruit = EatenFruit.init(entity: entity!, insertInto: moc)
        let fruitEaten = FruitEaten(entity: entity!, insertInto: moc)
        
        //var eatenFruit =
        
        fruitEaten.fruit = fruitName
        fruitEaten.date = datePicker.date.formatted(date: .abbreviated, time: .omitted)
        fruitEaten.carbohydrates = fruitCarbohydrates!
        fruitEaten.protein = fruitProtein!
        fruitEaten.fat = fruitFat!
        fruitEaten.calories = fruitCalories!
        fruitEaten.sugar = fruitSugar!
        print(datePicker.date)
        
        try! moc.save()
        
        self.dismiss(animated: true, completion: nil)
    }
}
