//
//  CommentCell.swift
//  Taqyeem
//
//  Created by mac on 12/14/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import Cosmos
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
}
