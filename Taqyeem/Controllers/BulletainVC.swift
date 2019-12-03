//
//  BulletainVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class BulletainVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var vm: [BulletainVM]?
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        getData()
    }
    
    func getData() {
        BulletainVM.getPublications() {bulletain, error in
            if error != nil {
                self.showAlert(title: "Failed", message: error!, buttonTitle: "OK")
            } else {
                self.vm = bulletain
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
        navigationItem.title = "النشرات التوعوية"
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
extension BulletainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralNewsCell", for: indexPath) as! GeneralNewsCell
        cell.bindDataBulletain(bulletain: vm![indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "NewsDetailsVC") as! NewsDetailsVC
        nextVC.pageTitle = "عرض نشرة توعوية"
        nextVC.bulletainVM = vm![indexPath.row]
        UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
    }
}
