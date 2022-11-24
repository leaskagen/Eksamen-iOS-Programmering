//
//  FruitDetailsViewController.swift
//  Eksamen
//
//  Created by Lea Skagen on 12/11/2022.
//

import Foundation
import UIKit
import CoreData

class Confetti : UILabel {
    override func draw(_ rect: CGRect) {

        }
}

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
    
    let container = NSPersistentContainer(name: "Eksamen")
    
    var objects = [Any]()

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
        
        fetchRequest.predicate = NSPredicate(
            format: "fruit = %@", fruit!.name
        )
        
        objects = try! moc.fetch(fetchRequest)
        
        print("objects fetch: \(objects.count)")
        
        if (objects.count > 0) {
            fruitConfetti(amount: objects.count)
        }
    }
    
    func fruitConfetti(amount: Int){
        print("Animating \(amount) confetti!")
        objects.forEach { object in
            let lbl = UILabel(frame: CGRect(x: randomXLocation(), y: -50, width: 25, height: 25))
               lbl.font = UIFont.systemFont(ofSize: 20)
            lbl.text = "\u{1F4AF}"
               view.addSubview(lbl)
            animateConfetti(confetti: lbl)
        }
    }
    
    // Generates a random location on the x-axis
    func randomXLocation() -> Double{
        let x = Double.random(in: 0...view.frame.width)
        return x
    }
    
    func animateConfetti(confetti: UILabel){
        let confetti = confetti
        
        let duration = TimeInterval.random(in: 3...5)
        let delay = TimeInterval.random(in: 0...1)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: { () -> Void in
            
            UIView.animateKeyframes(withDuration: duration, delay: delay, animations: {
                /*
                // Normal background
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.33, animations: {
                    //confetti.backgroundColor = .systemBackground
                })
                
                // Fade to red background
                UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.33, animations: {
                    //confetti.backgroundColor = .red
                })
                */
                // Back to normal background
                UIView.addKeyframe(withRelativeStartTime: 0.01, relativeDuration: 0.99, animations: {
                    confetti.transform = CGAffineTransformMakeTranslation(0, self.view.frame.height + 50)
                })
            })
        })
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
