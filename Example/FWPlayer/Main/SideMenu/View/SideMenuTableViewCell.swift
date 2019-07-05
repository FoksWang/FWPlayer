//
//  SideMenuTableViewCell.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-05.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var highlightView: UIView!
    
    static let className = "SideMenuTableViewCell"
    static let reuseIdentifier = className
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.highlightView.alpha = selected ? 1.0 : 0.0
        self.backgroundColor = selected ? .black : .clear
    }
    
    private func setupUI() {
    }
}

