//
//  AllCategoriesModel.swift
//  ShoppingAppDemo
//
//  Created by mudasir ahmad dar on 26/01/24.
//

import Foundation


struct AllCategoriesModel: Codable {
    let status: Bool
    let message, error: String
    let categories: [Category]
   
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
    let items: [MainItem]
   
}

// MARK: - Item
class MainItem:Codable{
    let id: Int
    let name: String
    let icon: String
    let price: Double
    var isfavourite: Bool = false
    var isCartItem:Bool = false
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try values.decodeIfPresent(String.self, forKey: .name)!
        icon = try values.decodeIfPresent(String.self, forKey: .icon) ?? ""
        price = try values.decodeIfPresent(Double.self, forKey: .price)!
        isfavourite = ((try values.decodeIfPresent(Bool.self, forKey: .isfavourite) ?? false))
        isCartItem = ((try values.decodeIfPresent(Bool.self, forKey: .isfavourite) ?? false) )
       
       
    }

}
