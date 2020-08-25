//
//  ResturantImagesVC.swift
//  Taqyeem
//
//  Created by Nourhan Hosny on 7/29/20.
//  Copyright © 2020 mazeedit. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
class ResturantImagesVC: UIViewController {
    var refreshControl = UIRefreshControl()
    private let imagePicker = UIImagePickerController()
    var imageBase: String = ""
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var resturant : ResturantVM!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        if self.resturant != nil {
            collectionView.delegate = self
            collectionView.dataSource =  self
            collectionView.reloadData()
        }
    }

    func loadImages() {
          if resturant != nil {
          collectionView.delegate = self
          collectionView.dataSource = self
          collectionView.reloadData()
          }
      }
      func loadData(){
          self.startLoadingActivity()
          ResturantVM.getResturantByID(resturantID: UserDefaultsAccess.sharedInstance.user?.store ?? 0) { resturant, errorMessage in
              self.stopLoadingActivity()
              if resturant != nil {
                self.resturant =  resturant
                self.collectionView.reloadData()
              }
              else {
              }
          }
      }
    
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
    

    func uploadImageOfResturant() {
        self.startLoadingActivity()
        ResturantVM.addimageToResturant(resturantID: UserDefaultsAccess.sharedInstance.user?.store ?? 0, image: self.imageBase) { success , errorMessage in
            self.stopLoadingActivity()
            if success {
                
                if let vc =  UIApplication.topViewController() as? OwnerController {
                  vc.loadData()
                }
            }
            else {
                self.showAlert(message: errorMessage ?? "")
            }
        }
    }
    @IBAction func addImages(_ sender: Any) {
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
extension ResturantImagesVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        imagePicker.navigationBar.backgroundColor = UIColor.black
        imagePicker.navigationBar.tintColor = UIColor.white
        imagePicker.modalPresentationStyle = .popover
        imagePicker.isEditing =  false
      
        UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().setBackgroundImage(nil, for: .default)
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
      @objc func btnDeleteImageClicked(_ sender: UIButton) {
        self.startLoadingActivity()
        ResturantVM.deleteImageFromResturant(imageId: sender.tag) { success, errorMessage in
            self.stopLoadingActivity()
            if success {
                self.loadData()
            }
        }
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

           self.imageBase =  pickedImage.toBase64(quality: .low)
        self.imagePicker.dismiss(animated: true) {
            self.uploadImageOfResturant()
        }
        }
    
}
extension ResturantImagesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.resturant.images.count
    
    }

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddFoodImage", for: indexPath) as! AddFoodImage
     cell.resturnatImage.image =  self.convertBase64StringToImage(imageBase64String: self.resturant.images[indexPath.row].storeImage ?? "")
      cell.removeBtn.tag =  self.resturant.images[indexPath.row].id ?? 0
        cell.removeBtn.addTarget(self, action: #selector(btnDeleteImageClicked(_:)), for: .touchUpInside)
        return cell
    
}
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    
    return CGSize(width: (self.collectionView.frame.width - 30) / 3 , height: 90)
}
}
