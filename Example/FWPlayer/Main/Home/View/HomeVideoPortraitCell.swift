//
//  HomeVideoPortraitCell.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-06.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class HomeVideoPortraitCell: UICollectionViewCell {
    static let className = "HomeVideoPortraitCell"
    static let reuseIdentifier = className
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var badgeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
