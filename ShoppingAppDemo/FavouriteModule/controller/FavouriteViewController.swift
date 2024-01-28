//
//  FavouriteViewController.swift
//  ShoppingAppDemo
//
//  Created by mudasir ahmad dar on 27/01/24.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    // MARK: OUTLETS--->
    @IBOutlet weak var tableviewFavourite: UITableView!
    
    // MARK: VARIABLES AND CONSTANTS
    var items : [FavItems]?
    
    //MARK: VIEW LIFE CYCLE --->
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    // MARK: METHODS--->
    func setupUI(){
        tableviewFavourite.delegate = self
        tableviewFavourite.dataSource = self
        tableviewFavourite.register(UINib(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavouriteTableViewCell")
        let items = DatabaseManager.shared.getFavItems()
        self.items = items
    }
    
    // MARK: ACTIONS-->
    @IBAction func favouriteBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

// MARK: EXTENSION
extension FavouriteViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell", for: indexPath)as! FavouriteTableViewCell
        let obj = items?[indexPath.row]
        cell.selectionStyle = .none
        cell.lblName.text = obj?.name
        if let price = obj?.price{
            cell.lblPrice.text = "\(price)"
        }
        
        if let imageUrl = URL(string: obj?.image ?? "") {
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
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}





