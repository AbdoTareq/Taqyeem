//
//  GeneralNewsVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class GeneralNewsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var vm: [NewsVM]?
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        getData()
    }
    
    func getData() {
        self.startLoadingActivity()
        NewsVM.getNews() {news, error in
            self.stopLoadingActivity()
            if error != nil {
                self.showAlert(title: "Failed", message: error!, buttonTitle: "OK")
            } else {
                self.vm = news
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func navBtnBack_Click(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "الأخبار"
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
}
extension GeneralNewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralNewsCell", for: indexPath) as! GeneralNewsCell
        cell.bindData(news: vm![indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "NewsDetailsVC") as! NewsDetailsVC
        nextVC.pageTitle = "عرض الخبر"
        nextVC.newsVM = vm![indexPath.row]
        UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
    }
}
