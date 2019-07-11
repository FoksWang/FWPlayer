//
//  DetailsPlayerCell.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-08.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Then

protocol DetailsPlayerCellDelegate: NSObjectProtocol {
    func playVideoAtDetailsPlayerCell(indexPath: IndexPath)
}

class DetailsPlayerCell: UITableViewCell {
    static let className = "DetailsPlayerCell"
    static let reuseIdentifier = className
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var additionInfoView: UIView!
    @IBOutlet weak var additionInfoViewHeight: NSLayoutConstraint! // 133
    @IBOutlet weak var bottomBlackView: UIView!
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var videoTypeLabel: UILabel!
    @IBOutlet weak var videoDescTextView: UITextView!
    
    
    private lazy var playButton = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "play"), for: .normal)
        $0.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.playVideoAtDetailsPlayerCell(indexPath: self.indexPath)
        }).disposed(by: rx.disposeBag)
    }
    
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
        
        self.coverImageView.addSubview(playButton)
        self.playButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.center.equalTo(containerView)
        }
    }
    
    func showAdditionInfoView() {
        additionInfoView.isHidden = false
        additionInfoViewHeight.constant = 133
    }
    
    func hideAdditionInfoView() {
        additionInfoView.isHidden = true
        additionInfoViewHeight.constant = 0
    }
    
    func showBottomBlackView() {
        bottomBlackView.isHidden = false
    }
    
    func hideBottomBlackView() {
        bottomBlackView.isHidden = true
    }
}
