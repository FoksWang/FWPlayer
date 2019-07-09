//
//  DetailsPlayerCell.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-08.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

protocol DetailsPlayerCellDelegate: NSObjectProtocol {
    func playVideoAtDetailsPlayerCell(indexPath: IndexPath)
}

class DetailsPlayerCell: UITableViewCell {
    
    @IBAction func playButtonClick(_ sender: UIButton) {
        self.delegate?.playVideoAtDetailsPlayerCell(indexPath: indexPath)
    }
    
    static let className = "DetailsPlayerCell"
    static let reuseIdentifier = className
    
    weak var delegate: DetailsPlayerCellDelegate?
    var indexPath = IndexPath(row: 0, section: 0)

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
