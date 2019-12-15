//
//  CommentsVC.swift
//  Taqyeem
//
//  Created by mac on 12/14/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class CommentsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var resturant : Resturant =  Resturant()
    @IBOutlet weak var barButonItemTitle: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource =  self
        tableView.reloadData()
        barButonItemTitle.title = "تعليقات مطعم  " + resturant.storeArabicName!
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.tabBarController?.tabBar.isHidden = true
        barButonItemTitle.tintColor =  UIColor.white
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
extension CommentsVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
