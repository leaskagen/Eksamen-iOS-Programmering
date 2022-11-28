//
//  GroupsListViewController.swift
//  Eksamen
//
//  Created by Lea Skagen on 23/11/2022.
//

import Foundation
import UIKit

class GroupsListViewController : UIViewController {
    
    @IBOutlet weak var listLabel : UILabel!
    @IBOutlet weak var groupFruitList : UITableView!
    
    var type: String?
    var query: String?
    
    var fruits = [Fruit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listLabel.text = query

        downloadFruits {
            // Reload table view after downloading fruits
            self.groupFruitList.reloadData()
        }
        
        groupFruitList.dataSource = self
        groupFruitList.delegate = self
        groupFruitList.register(UINib(nibName: "FruitListCell", bundle: nil), forCellReuseIdentifier: "FruitListCell")
    }
    
    func downloadFruits(completed: @escaping () -> ()){
        let url = URL(string: "https://www.fruityvice.com/api/fruit/\(type!)/\(query!)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    // Add JSON objects to fruit array
                    self.fruits = try! JSONDecoder().decode([Fruit].self, from: data)
                    // Sort fruit array in ascending order
                    self.fruits = self.fruits.sorted(by: { $0.id < $1.id })

                    DispatchQueue.main.async {
                        completed()
                    }
                }
            }
        }
        task.resume()
    }
}

extension GroupsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = groupFruitList.dequeueReusableCell(withIdentifier: "FruitListCell", for: indexPath) as! FruitListCell
        
        let fruit = fruits[indexPath.row]
        
        cell.FruitCellLabel.text = fruit.name
        cell.FruitCellImage.backgroundColor = ListViewController().colorFamilyImage(family: fruit.family)
        return cell
    }
}

extension GroupsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showGroupFruitDetails", sender: self)
        groupFruitList.deselectRow(at: indexPath, animated: true)
        groupFruitList.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FruitDetailsViewController {
            destination.fruit = fruits[groupFruitList.indexPathForSelectedRow!.row]
        }
    }
}
