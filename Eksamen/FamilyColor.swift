//
//  FamilyColor.swift
//  Eksamen
//
//  Created by Lea Skagen on 27/11/2022.
//

import Foundation
import UIKit

struct FamilyColor {
    let family: String
    var color: UIColor?
    
    public init(family: String, color: UIColor? = nil) {
        self.family = family
        self.color = color
    }
}
