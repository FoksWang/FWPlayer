//
//  HomeVideoPortraitCell.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-06.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class HomeVideoPortraitCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var badgeLabel: UILabel!
    
    static let className = "HomeVideoPortraitCell"
    static let reuseIdentifier = className
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
