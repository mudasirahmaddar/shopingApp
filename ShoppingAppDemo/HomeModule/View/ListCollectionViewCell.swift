//
//  ListCollectionViewCell.swift
//  ShoppingAppDemo
//
//  Created by mudasir ahmad dar on 26/01/24.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgFav: UIImageView!
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBOutlet weak var plusBtnImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    var isselected: Bool = false
    var isCartSelected : Bool = false
    var AddCartBtnAction: (()-> ())?
    var addFavBtnAction: (()-> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 10
       
       
    }

    @IBAction func addBtnAction(_ sender: Any) {
        if let action = AddCartBtnAction{
            action()
        }
        
    }
    @IBAction func addFavouriteBtnAction(_ sender: Any) {
        if let action = addFavBtnAction{
            action()
        }
    }
}
