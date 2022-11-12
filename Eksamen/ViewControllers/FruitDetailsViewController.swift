//
//  FruitDetailsViewController.swift
//  Eksamen
//
//  Created by Lea Skagen on 12/11/2022.
//

import Foundation
import UIKit

class FruitDetailsViewController: UIViewController {
    
    var fruit: Fruit?
    
    @IBOutlet weak var fruitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fruitLabel.text = fruit?.name
    }
    
}
