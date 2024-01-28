//
//  FavouriteTableViewCell.swift
//  ShoppingAppDemo
//
//  Created by mudasir ahmad dar on 27/01/24.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
   
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
 
    @IBOutlet weak var plusBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    @IBAction func favouriteBtnAction(_ sender: Any) {
    }
    
   
    
}
