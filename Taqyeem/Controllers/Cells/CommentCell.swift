//
//  CommentCell.swift
//  Taqyeem
//
//  Created by mac on 12/14/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import Cosmos
import Kingfisher
class CommentCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var vwRating: CosmosView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow(color: UIColor.gray)
    }
    func configure(comment : CommentVM)  {
        self.lblComment.text =  comment.comment.comments ?? ""
        //self.vwRating.rating = Double(comment.comment.ratingValue  ?? 0)
        self.lblUserName.text =  comment.comment.userFullName ?? ""
        let dataDecoded : Data = Data(base64Encoded: comment.comment.image ?? "", options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        userImage.image = decodedimage
        
    }
}
