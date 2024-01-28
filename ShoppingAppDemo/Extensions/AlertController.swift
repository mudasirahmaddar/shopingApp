//
//  AlertController.swift
//  ShoppingAppDemo
//
//  Created by mudasir ahmad dar on 28/01/24.
//

import Foundation
import UIKit
extension UIAlertController{
    static func alert(title:String,message:String,viewController:UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default){ (action:UIAlertAction) in
         
        })
       
        viewController.present(alert, animated: true)
        
    }
    
}
