//
//  ViewController.swift
//  Eksamen
//
//  Created by Lea Skagen on 11/11/2022.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var fruitListTableView: UITableView!
    
    var fruits = [Fruit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadFruits {
            self.fruitListTableView.reloadData()
        }
        
        fruitListTableView.dataSource = self
        fruitListTableView.delegate = self
        fruitListTableView.register(UINib(nibName: "FruitListCell", bundle: nil), forCellReuseIdentifier: "FruitListCell")
    }
    
    func downloadFruits(completed: @escaping () -> ()){
        let url = URL(string: "https://www.fruityvice.com/api/fruit/all")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    self.fruits = try! JSONDecoder().decode([Fruit].self, from: data)
                    DispatchQueue.main.async {
                        completed()
                    }
                }
            }
        }
        task.resume()
    }
}


    extension ListViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return fruits.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = fruitListTableView.dequeueReusableCell(withIdentifier: "FruitListCell", for: indexPath) as! FruitListCell
            
            let fruit = fruits[indexPath.row]
            
            cell.FruitCellLabel.text = fruit.name
            return cell
        }
    }
    
    extension ListViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print(indexPath.row)
            
            fruitListTableView.deselectRow(at: indexPath, animated: true)
            fruitListTableView.reloadData()
            
        }
    }
    
    

