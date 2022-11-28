//
//  ViewController.swift
//  Eksamen
//
//  Created by Lea Skagen on 11/11/2022.
//

import UIKit

// Global array so all classes have access to the different family colors
var familyColors = [Any]()

class ListViewController: UIViewController {
    
    @IBOutlet weak var fruitListTableView: UITableView!
    
    var fruits = [Fruit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadFruits {
            // Assign colors for the different fruit families
            self.assignFamilyColors()
            // Reload table view after downloading fruits
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
    
    // Assign all the different fruit families a color
    func assignFamilyColors(){
        fruits.forEach{ fruit in
            if(!familyColors.contains(where: {($0 as! FamilyColor).family == fruit.family})){
                familyColors.append(FamilyColor(family: fruit.family, color: createRandomColor()))
            }
        }
    }
    
    // Give color based on the fruit family
    func colorFamilyImage(family: String) -> UIColor {
        var color = UIColor()
        familyColors.forEach{ familyColor in
            if((familyColor as! FamilyColor).family == family) {
                color = (familyColor as! FamilyColor).color!
            }
        }
        return color
    }
    
    // Generate random color
    func createRandomColor() -> UIColor {
        let r = CGFloat.random(in: 0...1)
        let g = CGFloat.random(in: 0...1)
        let b = CGFloat.random(in: 0...1)
        let color = UIColor(red: r, green: g, blue: b, alpha: 1)
        return color
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
            cell.FruitCellImage.backgroundColor = colorFamilyImage(family: fruit.family)

            return cell
        }
    }
    
    extension ListViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "showFruitDetails", sender: self)
            print(indexPath.row)
            
            fruitListTableView.deselectRow(at: indexPath, animated: true)
            fruitListTableView.reloadData()
            
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? FruitDetailsViewController {
                destination.fruit = fruits[fruitListTableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
    

