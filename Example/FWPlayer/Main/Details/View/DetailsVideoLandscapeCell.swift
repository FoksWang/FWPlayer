//
//  DetailsVideoLandscapeCell.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-08.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

protocol DetailsVideoLandscapeCellDelegate: NSObjectProtocol {
    func playVideoAtDetailsVideoLandscapeCell(currentIndex: Int)
}

class DetailsVideoLandscapeCell: UITableViewCell {
    
    static let className = "DetailsVideoLandscapeCell"
    static let reuseIdentifier = className
    
    weak var delegate: DetailsVideoLandscapeCellDelegate?

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
