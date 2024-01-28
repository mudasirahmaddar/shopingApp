//
//  CartTableViewCell.swift
//  ShoppingAppDemo
//
//  Created by mudasir ahmad dar on 27/01/24.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    
  
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func minusBtnAction(_ sender: Any) {
    }
    
    @IBAction func plusBtnAction(_ sender: Any) {
    }
}
