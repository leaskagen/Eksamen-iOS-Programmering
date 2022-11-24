//
//  FruitDetailsViewController.swift
//  Eksamen
//
//  Created by Lea Skagen on 12/11/2022.
//

import Foundation
import UIKit
import CoreData

class FruitDetailsViewController: UIViewController {
    
    var fruit: Fruit?
    
    var color: UIColor?
    
    @IBOutlet weak var fruitLabel: UILabel!
    @IBOutlet weak var fruitColor: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genusLabel: UILabel!
    @IBOutlet weak var familyLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var nutritionsView: UIView!
    @IBOutlet weak var carbohydratesLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    
    @IBOutlet weak var sugarWarning: UIView!
    @IBOutlet weak var sugarWarningLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Top Color
        fruitColor.backgroundColor = assignColor(family: (fruit?.family.lowercased())!)
        
        // Title
        fruitLabel.text = fruit?.name
        
        // Fruit Information
        nameLabel.text = fruit?.name
        genusLabel.text = fruit?.genus
        familyLabel.text = fruit?.family
        orderLabel.text = fruit?.order
        
        // Nutrition Information
        carbohydratesLabel.text = fruit?.nutritions.carbohydrates?.formatted()
        proteinLabel.text = fruit?.nutritions.protein?.formatted()
        fatLabel.text = fruit?.nutritions.fat?.formatted()
        caloriesLabel.text = fruit?.nutritions.calories?.formatted()
        sugarLabel.text = fruit?.nutritions.sugar?.formatted()
        
        // Nutrition Border
        nutritionsView.layer.borderWidth = 2
        nutritionsView.layer.borderColor = UIColor.black.cgColor
        
        // If the fruit is high in sugar
        if ((fruit?.nutritions.sugar)! >= 10) {
            
            sugarWarningLabel.isHidden = false
            sugarWarning.backgroundColor = .red
            
            // Delay animation by one second
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1), execute: { () -> Void in
                
                UIView.animateKeyframes(withDuration: 5.5, delay: 0, options: [.repeat, .autoreverse], animations: {
                    
                    // Normal background
                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.33, animations: {
                        self.sugarWarning.backgroundColor = .systemBackground
                    })
                
                    // Fade to red background
                    UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.33, animations: {
                        self.sugarWarning.backgroundColor = .red
                    })
                    
                    // Back to normal background
                    UIView.addKeyframe(withRelativeStartTime: 0.66, relativeDuration: 0.33, animations: {
                        self.sugarWarning.backgroundColor = .systemBackground
                    })
                })
            })
        }
    }
    
    @IBAction func eatFruit(){
        print("I ate a \(fruit!.name)")
        
        performSegue(withIdentifier: "showRegisterEatenFruit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RegisterEatenFruitViewController {
            destination.fruitName = fruit?.name
            destination.fruitCarbohydrates = fruit?.nutritions.carbohydrates
            destination.fruitProtein = fruit?.nutritions.protein
            destination.fruitFat = fruit?.nutritions.fat
            destination.fruitSugar = fruit?.nutritions.sugar
            destination.fruitCalories = fruit?.nutritions.calories
        }
    }
    
    
}
