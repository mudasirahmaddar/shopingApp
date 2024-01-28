//
//  Database.swift
//  ShoppingAppDemo
//
//  Created by mudasir ahmad dar on 26/01/24.
//

import Foundation
import UIKit

final class DatabaseManager{
  static var shared = DatabaseManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
  func SaveFavData(item:MainItem){
      let entity = FavItems(context: context)

      entity.name = item.name
      entity.id = Int64(item.id)
      entity.image = item.icon
      entity.price = item.price

        do{
            try context.save()
        }catch{
            debugPrint(error)
        }
      
    }
    
   
    func getFavItems()-> [FavItems]{
        var items :[FavItems] = []
        do{
            items = try context.fetch(FavItems.fetchRequest())
           
        }catch{
            print("no data found")
        }
        
        return items
        
    }
    
    func deleteFav(FavItem:FavItems) {
      
        do{
            context.delete(FavItem)
            try context.save()
           
        }catch{
            print("no data found")
        }
        
        
    }
    
    func SaveToCart(item:MainItem){
        let entity = CartItems(context: context)

        entity.name = item.name
        entity.id = Int64(item.id)
        entity.image = item.icon
        entity.price = item.price

          do{
              try context.save()
          }catch{
              debugPrint(error)
          }
        
      }
    
    func getCartItems()-> [CartItems]{
        var items :[CartItems] = []
        do{
            items = try context.fetch(CartItems.fetchRequest())
           
        }catch{
            print("no data found")
        }
        
        return items
        
    }
    
    func deleteCartItem(cartItem:CartItems) {
      
        do{
            context.delete(cartItem)
            try context.save()
           
        }catch{
            print("no data found")
        }
        
      
        
        
    }
}
