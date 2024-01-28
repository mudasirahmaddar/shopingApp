//
//  ListTableViewCell.swift
//  ShoppingAppDemo
//
//  Created by mudasir ahmad dar on 26/01/24.
//

import UIKit
import Foundation



class ListTableViewCell: UITableViewCell {
   
    @IBOutlet weak var collectionviewList: UICollectionView!
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
   
   
    var  allcategory: Category?
   
    var AddToCart : (()->())?
    var removeToCart : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionviewList.delegate  = self
        collectionviewList.dataSource = self
        
        collectionviewList.register(UINib(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ListCollectionViewCell")
        
   
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}

extension ListTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allcategory?.items.count ?? 0

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath)as! ListCollectionViewCell
        
        self.lblTitle.text =  allcategory?.name
        let obj = allcategory?.items[indexPath.row]
        cell.lblItemName.text = obj?.name
        if let price = obj?.price {
            cell.lblPrice.text = "$\(price)"
        }
        if let imageUrl = URL(string: obj?.icon ?? "") {
                    // Download the image from the URL
                    DispatchQueue.global().async {
                        if let imageData = try? Data(contentsOf: imageUrl) {
                            debugPrint(imageData)
                            // Set the image on the main thread
           
                            DispatchQueue.main.async {
                                cell.imgView.image = UIImage(data: imageData)
                            }
                        }else{
                            print("some thing")
                       }
                        
                        debugPrint(imageUrl)
                    }
        }else{
            print("image url not found")
        }
       
        if (obj?.isfavourite)!{
            cell.imgFav.image = UIImage(systemName: "heart.fill")
            cell.imgFav.tintColor = .red
        }else{
            cell.imgFav.image = UIImage(systemName: "heart")
            cell.imgFav.tintColor = .black
        }
        
        if (obj?.isCartItem)!{
            cell.plusBtnImg.image = UIImage(systemName: "minus.rectangle.fill")
            
        }else{
            cell.plusBtnImg.image = UIImage(systemName: "plus.rectangle.fill")
            
        }

        
        cell.addFavBtnAction = {
            cell.isselected = !cell.isselected
            if cell.isselected{
                cell.imgFav.image = UIImage(systemName: "heart.fill")
                cell.imgFav.tintColor = .red
                DatabaseManager.shared.SaveFavData(item: obj!)
               
            }else{
                cell.imgFav.image = UIImage(systemName: "heart")
                cell.imgFav.tintColor = .black
                let favItems =  DatabaseManager.shared.getFavItems()
                   favItems.forEach({ Favitem in
                    if Favitem.name == obj?.name ?? ""{
                        DatabaseManager.shared.deleteFav(FavItem: Favitem)
                    }
                })
            }
        }

        cell.AddCartBtnAction = {
            cell.isCartSelected = !cell.isCartSelected
           
            if cell.isCartSelected{
                cell.plusBtnImg.image = UIImage(systemName: "minus.rectangle.fill")
                DatabaseManager.shared.SaveToCart(item: obj!)
                if  let action = self.AddToCart{
                  action()
                }
            }else{
                cell.plusBtnImg.image = UIImage(systemName: "plus.rectangle.fill")
                let cartItems = DatabaseManager.shared.getCartItems()
                cartItems.forEach({ Cartitem in
                    if Cartitem.id == obj?.id ?? 0{
                        DatabaseManager.shared.deleteCartItem(cartItem: Cartitem)
                    }
                })
              
                if  let action = self.removeToCart{
                    action()
                  }
               
            }
        }
        return cell
    }
    
    
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2.2, height: collectionView.frame.size.height/1)
    }
}
