//
//  CartViewController.swift
//  ShoppingAppDemo
//
//  Created by mudasir ahmad dar on 27/01/24.
//

import UIKit

class CartViewController: UIViewController {
    
    // MARK: OUTLETS--->
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var tableViewCart: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var btnCheckOut: UIButton!
    
    // MARK: VARIABLES AND CONSTANTS
    var cartItems : [CartItems]?
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
       setupUi()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnCheckOut.layer.cornerRadius = 10
    }
    
    // MARK: METHODS--->
    func setupUi(){
        tableViewCart.delegate = self
        tableViewCart.dataSource = self
        tableViewCart.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        priceView.layer.cornerRadius = 16
        cartItems = DatabaseManager.shared.getCartItems()
    }
    // MARK: ACTIONS-->
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkoutBtnAction(_ sender: Any) {
        UIAlertController.alert(title: " check out", message: "check out process pending", viewController: self)
    }
    
}

// MARK: EXTENSION
extension CartViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath)as! CartTableViewCell
        cell.selectionStyle = .none
        
        let cartObj = cartItems?[indexPath.row]
        cell.lblname.text = cartObj?.name
        let price = "\(String(describing: cartObj!.price))"
        cell.lblPrice.text = price
        let totalPrice = "\((cartObj!.price ) * 2)"
        cell.lblTotalPrice.text = totalPrice
        
        if let imageUrl = URL(string: cartObj?.image ?? "") {
            
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    
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
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
