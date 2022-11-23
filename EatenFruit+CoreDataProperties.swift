//
//  EatenFruit+CoreDataProperties.swift
//  Eksamen
//
//  Created by Lea Skagen on 23/11/2022.
//
//

import Foundation
import CoreData


extension EatenFruit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EatenFruit> {
        return NSFetchRequest<EatenFruit>(entityName: "EatenFruit")
    }

    @NSManaged public var date: Date?
    @NSManaged public var fruit: String?
    @NSManaged public var carbohydrates: Double
    @NSManaged public var protein: Double
    @NSManaged public var fat: Double
    @NSManaged public var sugar: Double
    @NSManaged public var calories: Double

}

extension EatenFruit : Identifiable {

}
