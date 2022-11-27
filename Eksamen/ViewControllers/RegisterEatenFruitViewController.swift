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
    @IBAction func saveEatenFruit() {
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        let moc = container.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "FruitsEaten", in: moc)

        let fruitEaten = FruitsEaten(entity: entity!, insertInto: moc)
        
        fruitEaten.fruit = fruitName!
        fruitEaten.date = datePicker.date
        fruitEaten.carbohydrates = fruitCarbohydrates!
        fruitEaten.protein = fruitProtein!
        fruitEaten.fat = fruitFat!
        fruitEaten.calories = fruitCalories!
        fruitEaten.sugar = fruitSugar!
        
        try! moc.save()
        
        self.dismiss(animated: true, completion: nil)
    }
}
