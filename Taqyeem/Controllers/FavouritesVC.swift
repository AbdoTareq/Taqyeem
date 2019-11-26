//
//  FavouritesVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class FavouritesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
    }
    func initNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "مطاعمي المفضلة"
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
extension FavouritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavResturantCell", for: indexPath) as! ResturantCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
