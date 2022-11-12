//
//  FruitListCell.swift
//  Eksamen
//
//  Created by Lea Skagen on 11/11/2022.
//

import UIKit

class FruitListCell: UITableViewCell {
    
    static let identifier = "FruitListCell"
    
    //let fRUIT_LIST_CELL = "FruitListCell"
    
    @IBOutlet weak var FruitListCell: UITableViewCell!
    @IBOutlet weak var FruitCellLabel: UILabel!
    @IBOutlet weak var FruitCellImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
