//
//  UpdateProfile.swift
//  Taqyeem
//
//  Created by mac on 12/21/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import AVFoundation
import MobileCoreServices

class UpdateProfile: UIViewController {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtFamilyName: UITextField!
    @IBOutlet weak var txtSecondName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    private let imagePicker = UIImagePickerController()
    var imageBase: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.leftBarButtonItem = nil
        self.tabBarController?.tabBar.isHidden =  true
        bindDataToUi()
        imagePicker.delegate = self
        userProfileImage.makeCircle()
    }

    func bindDataToUi() {
        self.txtMobile.text = UserDefaultsAccess.sharedInstance.user?.mobile ?? ""
        self.txtEmail.text = UserDefaultsAccess.sharedInstance.user?.email ?? ""
        self.txtFirstName.text = UserDefaultsAccess.sharedInstance.user?.firstName ?? ""
        self.txtSecondName.text = UserDefaultsAccess.sharedInstance.user?.lastName ?? ""
        self.txtFamilyName.text = UserDefaultsAccess.sharedInstance.user?.nickName ?? ""
        let dataDecoded : Data = Data(base64Encoded: UserDefaultsAccess.sharedInstance.user?.image ?? "", options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        if decodedimage != nil {
            userProfileImage.image = decodedimage
        }
    }

    @IBAction func btnSveClicked(_ sender: Any) {
        if txtFirstName.text == "" {
            showAlert(message: "برجاء ادخال الاسم الاول")
            return
        }
        if txtSecondName.text == "" {
            showAlert(message: "برجاء ادخال الاسم الخير")
            return
        }
        if txtFamilyName.text == "" {
            showAlert(message: "برجاء ادخال اسم العائلة")
            return
        }
        if txtMobile.text == "" {
            showAlert(message: "برجاء ادخال رقم الهاتف")
            return
        }
        if txtEmail.text == "" {
            showAlert(message: "برجاء ادخال البريد الالكتروني")
            return
        }
        if txtPassword.text == "" {
            showAlert(message: "برجاء ادخال كلمة المرور")
            return
        }
        if txtConfirmPassword.text == "" {
            showAlert(message: "برجاء ادخال تأكيد كلمة المرور")
            return
        }
        if txtConfirmPassword.text != txtPassword.text {
            showAlert(message: "كلمة المرور غير متطابقة")
            return
        }
        self.startLoadingActivity()
        let user = User(id: nil, firstName: txtFirstName.text!, lastName: txtSecondName.text!, nickName: txtFamilyName.text, email: txtEmail.text!, image: self.imageBase, token: nil, mobile: txtMobile.text!, password: txtPassword.text)
        self.startLoadingActivity()
        AuthenricationVM.update(user: user) {success, error in
            self.stopLoadingActivity()
            if !success {
                if error != nil {
                    self.showAlert(message: error!)
                } else {
                    self.stopLoadingActivity()
                    self.showAlert(message: "Unable to update profile")
                }
                return
            }
            self.login(mobile: self.txtMobile.text!, password: self.txtPassword.text!)
        }
        
    }
    
    @IBAction func updateUserProfile(_ sender: Any) {
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
    
    func login(mobile: String, password: String) {
        AuthenricationVM.login(mobile: mobile, password: password) {user, error in
            self.stopLoadingActivity()
            if error != nil {
                self.showAlert(message: "Unable to update profile")
                return
            }
            if user != nil {
                UserDefaultsAccess.sharedInstance.user = user?.user
                let banner = StatusBarNotificationBanner(title: "تم  تعديل حسابك بنجاح", style: .success)
                banner.show()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func btnLogoutClicked(_ sender: Any) {
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden =  false
    }
    
    @IBAction func btnLogoUtClicked(_ sender: Any) {
        UserDefaultsAccess.sharedInstance.clearData()
        UserDefaultsAccess.sharedInstance.skippedLogin  = false
        UserDefaultsAccess.sharedInstance.user = nil
        self.navigationController?.popViewController(animated: false, completion: {
            if let vc = UIApplication.topViewController()?.tabBarController as? MainTBC {
                vc.setUpOwnerVC()
            }
        })
        
    }
}
extension UpdateProfile: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        
        self.userProfileImage.image = pickedImage
        self.imageBase = (pickedImage.resizeImageUsingVImage(size: CGSize(width: 100, height: 100))?.toBase64(quality: .medium))!
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
