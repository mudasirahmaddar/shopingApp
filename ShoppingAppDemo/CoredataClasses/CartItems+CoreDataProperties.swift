//
//  CartItems+CoreDataProperties.swift
//  ShoppingAppDemo
//
//  Created by mudasir ahmad dar on 27/01/24.
//
//

import Foundation
import CoreData


extension CartItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItems> {
        return NSFetchRequest<CartItems>(entityName: "CartItems")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int64
    @NSManaged public var price: Double
    @NSManaged public var image: String?

}

extension CartItems : Identifiable {

}
