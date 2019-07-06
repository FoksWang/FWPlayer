//
//  CyclePagerViewCell.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-06.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class CyclePagerViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let className = "CyclePagerViewCell"
    static let reuseIdentifier = className
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
