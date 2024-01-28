//
//  HomeViewController.swift
//  ShoppingAppDemo
//
//  Created by mudasir ahmad dar on 26/01/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    // MARK: OUTLETS--->
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var tableViewList: UITableView!
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var bgViewLblCount: UIView!
    @IBOutlet weak var categoriesBtn: UIButton!
    
    // MARK: VARIABLES AND CONSTANTS -->
    var allCategoriesModel: AllCategoriesModel?
    var isCellExpanded = [Bool](repeating: false, count:5 )
    
    //MARK: VIEW LIFE CYCLE --->
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let cartItem = DatabaseManager.shared.getCartItems()
        self.lblCartCount.text = "\(cartItem.count)"
        categoriesBtn.isHidden = false
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationView.layer.cornerRadius = 10
        bgViewLblCount.layer.cornerRadius = bgViewLblCount.frame.size.height/2
        categoriesBtn.layer.cornerRadius = 8
    }
    
    
    
    // MARK: METHODS--->
    func setupUi(){
        tableViewList.delegate = self
        tableViewList.dataSource = self
        
        guard  let data = AllCategoriesModel.parse(jsonFile: "shopping") else {return}
        let favdata = DatabaseManager.shared.getFavItems()
        let cartData =  DatabaseManager.shared.getCartItems()
        
        data.categories.forEach { category in
            category.items.forEach { item in
                if let _ = favdata.first(where: {$0.id == item.id }){
                    item.isfavourite = true
                }else{
                    item.isfavourite = false
                }
            }
            
        }
        
        data.categories.forEach { category in
            category.items.forEach { item in
                if let _ = cartData.first(where: {$0.id == item.id }){
                    item.isCartItem = true
                }else{
                    item.isCartItem = false
                }
            }
            
        }
        allCategoriesModel = data
        tableViewList.reloadData()
        
    }
    
    
    // MARK: ACTIONS-->
    @IBAction func favouriteBtnAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FavouriteViewController")as! FavouriteViewController
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    @IBAction func addCartBtnAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CartViewController")as! CartViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func categoriesBtnAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "CategoriesViewController")as! CategoriesViewController
        categoriesBtn.isHidden = true
        vc.dismiss = {
            self.categoriesBtn.isHidden = false
        }
        navigationController?.present(vc, animated: true)
    }
}



// MARK: EXTENSION
extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCategoriesModel?.categories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath)as! ListTableViewCell
        
        let obj = allCategoriesModel?.categories[indexPath.row]
        cell.allcategory = obj
        if isCellExpanded[indexPath.row]{
            cell.imgView?.image = UIImage(systemName: "chevron.up")
        }else{
            cell.imgView?.image = UIImage(systemName: "chevron.down")
        }
        
        
        cell.AddToCart = {
            let cartItem = DatabaseManager.shared.getCartItems()
            self.lblCartCount.text = "\(cartItem.count)"
           
            UIAlertController.alert(title: " item is added", message: "item is added to cart", viewController: self)
            
        }
        cell.removeToCart = {
            let cartItem = DatabaseManager.shared.getCartItems()
            self.lblCartCount.text = "\(cartItem.count)"
            UIAlertController.alert(title: " item is removed", message: "item is removed from cart", viewController: self)
            
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return isCellExpanded[indexPath.row] ? 80 : 360
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        isCellExpanded[indexPath.row].toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
