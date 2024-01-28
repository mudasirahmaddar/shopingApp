//
//  Database.swift
//  ShoppingAppDemo
//
//  Created by mudasir ahmad dar on 26/01/24.
//

import Foundation
import UIKit
import CoreData

final class DatabaseManager{
  static var shared = DatabaseManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init(){}
  
    
    func Save(item:MainItem,type:String){
        
        if type == "cart"{
            let entity = CartItems(context: context)
            entity.name = item.name
            entity.id = Int64(item.id)
            entity.image = item.icon
            entity.price = item.price
              doCatchHander()

        }else{
            let entity = FavItems(context: context)
            entity.name = item.name
            entity.id = Int64(item.id)
            entity.image = item.icon
            entity.price = item.price

             doCatchHander()
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
    
    func delete<T>(item:T){
           
            do{
                context.delete(item as! NSManagedObject)
                try context.save()
                
            }catch{
                print("error while deleting")
            }
        
    }

    func doCatchHander(){
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
 
}
