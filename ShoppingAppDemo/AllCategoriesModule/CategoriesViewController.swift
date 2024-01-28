//
//  CategoriesViewController.swift
//  ShoppingAppDemo
//
//  Created by mudasir ahmad dar on 28/01/24.
//

import UIKit

class CategoriesViewController: UIViewController {
    @IBOutlet weak var btnCross: UIButton!
    
    @IBOutlet weak var listView: UIView!
    var dismiss : (()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.layer.cornerRadius = 10
        btnCross.layer.cornerRadius =  btnCross.frame.size.height/2
    }
    

    @IBAction func crossBtnAction(_ sender: Any) {
        if  let action = dismiss{
            action()
        }
        dismiss(animated: true)
    }
    

}
