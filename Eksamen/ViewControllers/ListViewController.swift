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
}

func assignColor(family: String) -> UIColor {
    
    enum FruitFamily: String {
        case musaceae
        case rutaceae
        case rosaceae
        case solanaceae
        case bromeliaceae
        case cucurbitaceae
        case anacardiaceae
        case myrtaceae
        case caricaceae
        case vitaceae
        case ebenaceae
        case malvaceae
        case ericaceae
        case actinidiaceae
        case sapindaceae
        case moraceae
        case grossulariaceae
        case passifloraceae
        case cactaceae
        case lythraceae
        case lauraceae
    }
    
    let currentFamily = FruitFamily(rawValue: family)
    
    var color: UIColor
    
    switch currentFamily! {
        
    case FruitFamily.musaceae:
        color = UIColor(red: 1, green: 0.95, blue: 0.4, alpha: 1)
        
    case FruitFamily.rutaceae:
        color = UIColor(red: 1, green: 0.7, blue: 0, alpha: 1)
        
    case FruitFamily.rosaceae:
        color = UIColor(red: 0.5, green: 0.9, blue: 0.1, alpha: 1)
        
    case FruitFamily.solanaceae:
        color = UIColor(red: 0.91, green: 0.1, blue: 0.1, alpha: 1)
        
    case FruitFamily.bromeliaceae:
        color = UIColor(red: 0.95, green: 1, blue: 0, alpha: 1)
        
    case FruitFamily.cucurbitaceae:
        color = UIColor(red: 0, green: 1, blue: 0.6, alpha: 1)
        
    case FruitFamily.anacardiaceae:
        color = UIColor(red: 1, green: 0.445, blue: 0, alpha: 1)
        
    case FruitFamily.myrtaceae:
        color = UIColor(red: 0.7, green: 0, blue: 1, alpha: 0.8)
        
    case FruitFamily.caricaceae:
        color = UIColor(red: 0, green: 0.8, blue: 1, alpha: 1)
        
    case FruitFamily.vitaceae:
        color = UIColor(red: 0.45, green: 0, blue: 1, alpha: 1)
        
    case FruitFamily.ebenaceae:
        color = UIColor(red: 0.2, green: 0.4, blue: 1, alpha: 0.6)
        
    case FruitFamily.malvaceae:
        color = UIColor(red: 0.85, green: 1, blue: 0.42, alpha: 1)
        
    case FruitFamily.ericaceae:
        color = UIColor(red: 1, green: 0, blue: 0.35, alpha: 1)
        
    case FruitFamily.actinidiaceae:
        color = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
        
    case FruitFamily.sapindaceae:
        color = UIColor(red: 1, green: 0.85, blue: 0.85, alpha: 0.75)
        
    case FruitFamily.moraceae:
        color = UIColor(red: 0.5, green: 0, blue: 0.5, alpha: 1)
        
    case FruitFamily.grossulariaceae:
        color = UIColor(red: 1, green: 1, blue: 0.85, alpha: 1)
        
    case FruitFamily.passifloraceae:
        color = UIColor(red: 1, green: 0.28, blue: 0, alpha: 1)
        
    case FruitFamily.cactaceae:
        color = UIColor(red: 0, green: 1, blue: 0.35, alpha: 1)
        
    case FruitFamily.lythraceae:
        color = UIColor(red: 0.75, green: 0, blue: 0.2, alpha: 1)
        
    case FruitFamily.lauraceae:
        color = UIColor(red: 0.5, green: 0.5, blue: 0.2, alpha: 1)
    }
    
    return color
}


    extension ListViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return fruits.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = fruitListTableView.dequeueReusableCell(withIdentifier: "FruitListCell", for: indexPath) as! FruitListCell
            
            let fruit = fruits[indexPath.row]
            
            cell.FruitCellLabel.text = fruit.name
            cell.FruitCellImage.backgroundColor = assignColor(family: fruit.family.lowercased())
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
                /*
                destination.color = assignColor(family: fruits[fruitListTableView.indexPathForSelectedRow!.row].family)
                 */
            }
        }
    }
    
    

