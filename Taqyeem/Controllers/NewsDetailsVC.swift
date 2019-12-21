//
//  NewsDetailsVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
class NewsDetailsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var pageTitle = ""
    var newsVM: NewsVM?
    var bulletainVM: BulletainVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initNavigationBar()
    }
    @IBAction func navBtnBack_Click(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = pageTitle
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
extension NewsDetailsVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        var title = ""
        var details = ""
        var image = ""
        var date = ""
        if newsVM != nil {
            title = newsVM!.title
            details = newsVM!.body
            image = newsVM!.image
            date = newsVM!.date
        } else if bulletainVM != nil {
            title = bulletainVM!.title
            details = bulletainVM!.body
            image = bulletainVM!.image
            date = bulletainVM!.date
        }
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "NewsTitleCell", for: indexPath) as! NewsTitleCell
            (cell as! NewsTitleCell).bindData(title: title, date: date)
            return cell
        }
        if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailsCell", for: indexPath) as! NewsDetailsCell
            (cell as! NewsDetailsCell).bindData(body: details)
            return cell
        }
        if indexPath.row == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "NewsImageCell", for: indexPath) as! NewsImageCell
            (cell as! NewsImageCell).bindData(base64: image)
            return cell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
