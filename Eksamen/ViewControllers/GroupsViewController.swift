//
//  GroupsViewController.swift
//  Eksamen
//
//  Created by Lea Skagen on 22/11/2022.
//

import Foundation
import UIKit

class GroupsViewController: UIViewController {
    
    @IBOutlet weak var groupsCollectionView: UICollectionView!
    
    var fruits = [Fruit]()
    
    var families = [String]()
    var genuses = [String]()
    var orders = [String]()
    
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadFruits {
            // Reload table view after downloading fruits
            self.groupsCollectionView.reloadData()
        }
        
        groupsCollectionView.delegate = self
        groupsCollectionView.dataSource = self
        groupsCollectionView.register(UINib(nibName: "GroupsCell", bundle: nil), forCellWithReuseIdentifier: "GroupsCell")
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
                    
                    self.fruits.forEach{
                        Fruit in
                        // Sort out the family, genus and orders
                        if(!self.families.contains(Fruit.family) && !Fruit.family.contains("None")){
                            self.families.append(Fruit.family)
                            self.groups.append(Group(element: Fruit.family, type: "family"))
                        }
                        if(!self.genuses.contains(Fruit.genus) && !Fruit.genus.contains("None")){
                            self.genuses.append(Fruit.genus)
                            self.groups.append(Group(element: Fruit.genus, type: "genus"))
                        }
                        if(!self.orders.contains(Fruit.order) && !Fruit.order.contains("None")){
                            self.orders.append(Fruit.order)
                            self.groups.append(Group(element: Fruit.order, type: "order"))
                        }
                    }
                    DispatchQueue.main.async {
                        completed()
                    }
                }
            }
        }
        task.resume()
    }
}


extension GroupsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Prepare type and element for segue
        let groupType = groups[indexPath.section].type
        var groupElement: String = ""
        if (groupType == "family") {
            groupElement = families[indexPath.item]
        } else if (groupType == "genus") {
            groupElement = genuses[indexPath.item]
        } else if (groupType == "order") {
            groupElement = orders[indexPath.item]
        }
        
        // Send group type and element with segue
        let sender: [String: Any?] = ["type": groupType, "element": groupElement]
        performSegue(withIdentifier: "showGroupsFruitList", sender: sender)
        
        groupsCollectionView.deselectItem(at: indexPath, animated: true)
        groupsCollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GroupsListViewController {
            let object = sender as! [String: Any?]
            destination.type = object["type"] as? String
            destination.query = object["element"] as? String
        }
    }
}

extension GroupsViewController: UICollectionViewDataSource {
    // Number of Sections in collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var amountOfSections = [String]()
        groups.forEach { Group in
            if (!amountOfSections.contains(Group.type)) {
                amountOfSections.append(Group.type)
            }
        }
        return amountOfSections.count
    }
    
    // Number of items in each section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (groups[section].type == "family") {
            print("families: \(families)")
            return families.count
        } else if (groups[section].type == "genus") {
            print("genuses: \(genuses)")
            return genuses.count
        } else if (groups[section].type == "order") {
            print("orders: \(orders)")
            return orders.count
        } else {
            return 0
        }
    }
    
    // Create cell item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupsCell", for: indexPath) as! GroupsCell
        
        // Cell text and background color based on section
        if (groups[indexPath.section].type == "family") {
            cell.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 1, alpha: 1)
            cell.groupLabel.text = families[indexPath.item]
        } else if (groups[indexPath.section].type == "genus") {
            cell.backgroundColor = UIColor(red: 1, green: 1, blue: 0, alpha: 0.5)
            cell.groupLabel.text = genuses[indexPath.item]
        } else if (groups[indexPath.section].type == "order") {
            cell.backgroundColor = UIColor(red: 0, green: 1, blue: 1, alpha: 0.4)
            cell.groupLabel.text = orders[indexPath.item]
        }
        
        return cell
    }
    
    // Reusable section header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Get header
        let header = collectionView.dequeueReusableSupplementaryView(
          ofKind: kind,
          withReuseIdentifier: "GroupsCollectionHeader",
          for: indexPath)
        
        guard let groupCollectionHeader = header as? GroupsCollectionHeader
        else { return header }
        
        // Header title is section type
        let groupType = groups[indexPath.section].type
        groupCollectionHeader.groupCollectionLabel.text = groupType.capitalized
        return groupCollectionHeader
    }
}

extension GroupsViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Auto size collection view cells
        return CGSize(width: collectionView.frame.size.width/2.1, height: 55)
    }
}
