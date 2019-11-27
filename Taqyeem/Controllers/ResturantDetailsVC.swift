//
//  ResturantDetailsVC.swift
//  Taqyeem
//
//  Created by mac on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class ResturantDetailsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var resturantName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
    }

    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = title
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
extension ResturantDetailsVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantGeneralInfo", for: indexPath) as! ResturantGeneralInfo
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantLocation", for: indexPath) as! ResturantLocation
            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantImages", for: indexPath) as! ResturantImages
            cell.loadData()
            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCommentRateCell", for: indexPath) as! ShowCommentRateCell
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantActivitiesDirections", for: indexPath) as! ResturantActivitiesDirections
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
