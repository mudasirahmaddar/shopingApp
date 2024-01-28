//
//  FavItems+CoreDataProperties.swift
//  ShoppingAppDemo
//
//  Created by mudasir ahmad dar on 27/01/24.
//
//

import Foundation
import CoreData


extension FavItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavItems> {
        return NSFetchRequest<FavItems>(entityName: "FavItems")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var price: Double

}

extension FavItems : Identifiable {

}
