//
//  HomeCyclePagerViewCell.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-06.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class HomeCyclePagerViewCell: UICollectionViewCell {
    static let className = "HomeCyclePagerViewCell"
    static let reuseIdentifier = className

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
