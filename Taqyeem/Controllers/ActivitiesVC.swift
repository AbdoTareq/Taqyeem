//
//  ActivitiesVC.swift
//  Taqyeem
//
//  Created by mac on 12/23/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class ActivitiesVC: UIViewController {
    
    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var activities: [ActivityVM]?
    var storeID :Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        getactivities()
        navigationItem.setHidesBackButton(true, animated: false)
        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = 100.0
               tableView.rowHeight = UITableView.automaticDimension
        barButton.tintColor =  UIColor.white
    }
    func getactivities() {
        self.startLoadingActivity()
        ActivityVM.getResturantActivities(storeID: storeID) { activities, errorMessage in
            self.stopLoadingActivity()
            if errorMessage != nil {
                self.showAlert(message: errorMessage!)
                return
            }
            guard let activities = activities else {return}
            self.activities = activities
            self.tableView.delegate = self
            self.tableView.dataSource =  self
            self.tableView.reloadData()
        }
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension ActivitiesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! TitleCell
        cell.lblTitle.text =  self.activities![indexPath.row].name
        cell.containerView.addShadow(color: UIColor.gray)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
