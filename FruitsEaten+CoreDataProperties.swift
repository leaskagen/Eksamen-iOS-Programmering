//
//  FruitsEaten+CoreDataProperties.swift
//  Eksamen
//
//  Created by Lea Skagen on 26/11/2022.
//
//

import Foundation
import CoreData

extension FruitsEaten {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FruitsEaten> {
        return NSFetchRequest<FruitsEaten>(entityName: "FruitsEaten")
    }

    @NSManaged public var calories: Double
    @NSManaged public var carbohydrates: Double
    @NSManaged public var date: Date?
    @NSManaged public var fat: Double
    @NSManaged public var fruit: String?
    @NSManaged public var protein: Double
    @NSManaged public var sugar: Double

}

extension FruitsEaten : Identifiable {

}
