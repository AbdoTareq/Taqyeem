//
//  CircleExt.swift
//  Trolly
//
//  Created by sameh on 9/3/18.
//  Copyright © 2018 soleek. All rights reserved.
//

import Foundation
import UIKit

protocol CircleP
{
    var makeCircle:Bool {get set }
}

extension CircleP where Self:UIView
{
    func configureCircle()
    {
        if makeCircle
        {
            layer.masksToBounds = false
            layer.cornerRadius = frame.height / 2
            clipsToBounds = true
        }
    }
}
