//
//  FavouritesVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class FavouritesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var resturants: [ResturantVM]?
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        getData()
    }
    func getData() {
        self.startLoadingActivity()
        ResturantVM.getFavourites() {resturants, error in
            self.stopLoadingActivity()
            if error != nil {
                self.showAlert(message: error!)
                return
            }
            guard let resturants = resturants else {return}
            self.resturants = resturants
            self.tableView.delegate =  self
            self.tableView.dataSource =  self
            self.tableView.reloadData()
            
        }
    }
    @IBAction func navBtnBack_Click(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "مطاعمي المفضلة"
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
extension FavouritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resturants!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavResturantCell", for: indexPath) as! ResturantCell
        cell.configureCell(resturant: self.resturants![indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "ResturantDetailsVC") as! ResturantDetailsVC
        nextVC.resturantName = "مطعم هليوبلس"
        UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
    }
}
