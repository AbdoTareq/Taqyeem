//
//  ResturantImages.swift
//  Taqyeem
//
//  Created by mac on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class ResturantImages: UITableViewCell {
    @IBOutlet weak var lblNone: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var images = [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow(color: UIColor.gray)
        collectionView.isHidden = images.count == 0
        lblNone.isHidden = images.count != 0
        
    }
    func loadData()  {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
}
extension ResturantImages : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResturantICollectionViewmage", for: indexPath) as! ResturantICollectionViewmage
        return cell
        
    }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    
}
