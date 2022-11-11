//
//  ViewController.swift
//  Eksamen
//
//  Created by Lea Skagen on 11/11/2022.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var fruitListTableView: UITableView!
    
    let fruits = ["Mango", "Pineapple", "Orange"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fruitListTableView.dataSource = self
        fruitListTableView.delegate = self
        fruitListTableView.register(UINib(nibName: "FruitListCell", bundle: nil), forCellReuseIdentifier: "FruitListCell")
    }


}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = fruitListTableView.dequeueReusableCell(withIdentifier: "FruitListCell", for: indexPath) as! FruitListCell
        
        let fruit = fruits[indexPath.row]
        /*
        
        if (villager.isChecked == true) {
            cell.checkmark.isHidden = false
        } else {
            cell.checkmark.isHidden = true
        }
        */
        
        
        cell.FruitCellLabel.text = fruit
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //villagers[indexPath.row].isChecked.toggle()
        
        /*
        print(villager.isChecked)
        villager.isChecked.toggle()
        print(villager.isChecked)
        */
        /*
        if (villager.isChecked == true) {
            cell.checkmark.isHidden = false
        } else {
            cell.checkmark.isHidden = true
        }
        */
        
        tableView.reloadData()
        
        //let secondViewController = SecondViewController.init(nibName: nil, bundle: nil)
        //present.(secondViewController, animated: false
        
    }
}


