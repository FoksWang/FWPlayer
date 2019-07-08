//
//  HomeVideosHeaderView.swift
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

typealias HomeHeaderViewClick = ([VideoModel]?) -> Void

class HomeVideosHeaderView: UICollectionReusableView {
    static let className = "HomeVideosHeaderView"
    static let reuseIdentifier = className
    
    var headerViewClick : HomeHeaderViewClick?
    
    private lazy var titleLabel = UILabel().then {
        $0.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        $0.textColor = .black
        $0.text = "N/A"
    }
    
    private lazy var seeMoreButton = UIButton(type: .custom).then {
        $0.setTitle("See more", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        $0.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.headerViewClick?(self.videoList)
        }).disposed(by: rx.disposeBag)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        self.addSubview(self.seeMoreButton)
        self.seeMoreButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    var videoList: [VideoModel]? {
        didSet {
            guard let model = videoList else { return }
            self.titleLabel.text = model.first?.type?.capitalized
        }
    }
}
