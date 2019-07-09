//
//  DetailsPlayerCell.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-08.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

protocol DetailsPlayerCellDelegate: NSObjectProtocol {
    func playVideoAtDetailsPlayerCell(currentIndex: Int)
}

class DetailsPlayerCell: UITableViewCell {
    
    
    static let className = "DetailsPlayerCell"
    static let reuseIdentifier = className
    
    weak var delegate: DetailsPlayerCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        self.selectionStyle = .none
    }
}
