//
//  CreateReportImagesCell.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/27/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class CreateReportImagesCell: UITableViewCell {
    
    @IBOutlet weak var imgPlus: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblAddImage: UILabel!
    var images = [ComplaintImage]()
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow(color: UIColor.gray)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}
extension CreateReportImagesCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResturantICollectionViewmage", for: indexPath) as! ResturantICollectionViewmage
        cell.img.image = images[indexPath.row].img
        cell.img.contentMode = .scaleAspectFit
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
