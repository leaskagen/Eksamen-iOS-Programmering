//
//  FruitEaten+CoreDataProperties.swift
//  Eksamen
//
//  Created by Lea Skagen on 24/11/2022.
//
//

import Foundation
import CoreData


extension FruitEaten {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FruitEaten> {
        return NSFetchRequest<FruitEaten>(entityName: "FruitEaten")
    }

    @NSManaged public var date: String?
    @NSManaged public var fruit: String?
    @NSManaged public var carbohydrates: Double
    @NSManaged public var protein: Double
    @NSManaged public var fat: Double
    @NSManaged public var sugar: Double
    @NSManaged public var calories: Double

}

extension FruitEaten : Identifiable {

}
