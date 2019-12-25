//
//  CreateReportVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/27/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import AVFoundation
import MobileCoreServices
class CreateReportVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var reportTitle :String = ""
    var reportDescription :String = ""
    var storeName :String = ""
    var complainType = ""
    var complainId = 0
    var images = [ComplaintImage]()
    private let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        imagePicker.delegate = self
    }
    @IBAction func navBtnBack_Click(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    func initNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "#CCA121")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "تقديم بلاغ/شكوي"
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    @objc func btnSubmitReportClicked(_ sender: UIButton) {
        prepareReportsData()
        if self.complainId == 0 || storeName == "" || reportTitle == "" || reportDescription == "" {
            let banner = StatusBarNotificationBanner(title: "من فضلك ادخل جمبع البيانات", style: .warning)
            banner.show()
        }
        else {
            self.startLoadingActivity()
            
            ReportVM.submitReport(complainInformation: self.reportTitle, complainText: self.reportDescription , mobile: UserDefaultsAccess.sharedInstance.user?.mobile ?? "", storename: self.storeName, complainId: self.complainId) { success , errorMessage in
                self.stopLoadingActivity()
                if success {
                    let banner = StatusBarNotificationBanner(title: "تم اضافه بلاغك بنجاح", style: .success)
                    banner.show()
                    self.navigationController?.popViewController(animated: true)
                }
                else {
                    let banner = StatusBarNotificationBanner(title: errorMessage!, style: .warning)
                    banner.show()
                }
            }
        }
    }
    func prepareReportsData()  {
        for cellItem in  self.tableView.visibleCells {
            if  let cell =  cellItem as? CreateReportTitleCell {
                self.reportTitle = cell.txtTitle!.text!
            }
            if let  cell = cellItem as? CreateReportDetailsCell {
                self.reportDescription  = cell.txtDetails.text!
            }
            if let  cell = cellItem as? ReportResturantName {
                self.storeName  = cell.resturantName.text!
            }
        }
    }
    func reloadReportType() {
        let indexPath = IndexPath(item: 3, section: 0)
        tableView.reloadRows(at: [indexPath], with: .top)
    }
    @objc func openImagePicker(_ gesture: UITapGestureRecognizer) {
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        switch cameraAuthorizationStatus {
        case .denied:
            self.showAlert(title: "تنبيه", message:"يجب تفعيل صلاحية الكاميرا لالتقاط الصور", buttonTitle: "موافق")
            break
        case .authorized:
            DispatchQueue.main.async {
                self.onloadCamera()
            }
            break
        case .restricted: break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.onloadCamera()
                    }
                } else {
                    self.showAlert(title: "تنبيه", message:"يجب تفعيل صلاحية الكاميرا لالتقاط الصور", buttonTitle: "موافق")
                }
            }
        }
    }
}
extension CreateReportVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CreateReportTitleCell", for: indexPath) as! CreateReportTitleCell
            return cell
        }
        if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CreateReportDetailsCell", for: indexPath) as! CreateReportDetailsCell
            return cell
        }
        if indexPath.row == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "ReportResturantName", for: indexPath) as! ReportResturantName
            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReportType", for: indexPath) as! ReportType
            if self.complainType != ""{
                cell.reportType.text = self.complainType
            }
            return cell
        }
        if indexPath.row == 4 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CreateReportImagesCell", for: indexPath) as! CreateReportImagesCell
            (cell as! CreateReportImagesCell).images = images
            let openPicker = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
            let openPickerImg = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
            (cell as! CreateReportImagesCell).lblAddImage.addGestureRecognizer(openPicker)
            (cell as! CreateReportImagesCell).imgPlus.addGestureRecognizer(openPickerImg)
            (cell as! CreateReportImagesCell).collectionView.reloadData()
            return cell
        }
        if indexPath.row == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreateReportSendCell", for: indexPath) as! CreateReportSendCell
            cell.btnSubmitReport.addTarget(self, action: #selector(btnSubmitReportClicked(_:)), for: .touchUpInside)
            return cell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ComplainTypesVC") as! ComplainTypesVC
            nextVC.modalTransitionStyle = .crossDissolve
            nextVC.modalPresentationStyle = .overCurrentContext
            present(nextVC, animated: false, completion: nil)
            
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension CreateReportVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func onloadCamera() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
            self.openCamera()
        })
        alert.addAction(UIAlertAction(title: "Gallery", style: .default) { _ in
            self.openGallary()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func openGallary() {
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        let imageBase = (pickedImage.resizeImageUsingVImage(size: CGSize(width: 100, height: 100))?.toBase64(quality: .medium))!
        self.images.append(ComplaintImage(string: imageBase, img: pickedImage))
        imagePicker.dismiss(animated: true, completion: {
            self.tableView.reloadData()
        })
    }
}
