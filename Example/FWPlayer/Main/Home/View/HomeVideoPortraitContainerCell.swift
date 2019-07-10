//
//  HomeVideoPortraitContainerCell.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-07.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Then
import SnapKit
import Kingfisher

protocol HomeVideoPortraitContainerCellDelegate: NSObjectProtocol {
    func didSelectedVideoPortraitCell(videoList: [VideoModel])
}

class HomeVideoPortraitContainerCell: UICollectionViewCell {
    static let className = "HomeVideoPortraitContainerCell"
    static let reuseIdentifier = className
    
    private var data = [VideoModel]()
    weak var delegate: HomeVideoPortraitContainerCellDelegate?
    
    private lazy var layout = UICollectionViewFlowLayout.init().then {
        $0.scrollDirection = .horizontal
    }

    private lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout).then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
//        $0.contentInsetAdjustmentBehavior = .never

        $0.register(UINib(nibName: HomeVideoPortraitCell.className, bundle: nil), forCellWithReuseIdentifier: HomeVideoPortraitCell.reuseIdentifier)
    }
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dataModel: [VideoModel]? {
        didSet{
            guard let model = dataModel else { return }
            self.data = model
            self.collectionView.reloadData()
        }
    }
    
    private func setupUI() {
        self.addCollectionView()
    }
    
    private func addCollectionView() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
}

extension HomeVideoPortraitContainerCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeVideoPortraitCell.reuseIdentifier, for: indexPath) as! HomeVideoPortraitCell
        let url = URL(string: data[indexPath.row].imagePortraitUrl!)
        let image = UIImage(named: "image_placeholder_portrait")
        cell.posterImageView.kf.setImage(with: url, placeholder: image)
        
        if  data[indexPath.row].type == "swedish" {
            cell.badgeView.isHidden = false
            cell.badgeLabel.text = "Live"
        } else {
            cell.badgeView.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoModel = data.remove(at: indexPath.row)
        data.insert(videoModel, at: 0)
        delegate?.didSelectedVideoPortraitCell(videoList: data)
    }
    
    // inner margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // margin between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // minimum line margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 133, height: 200)
    }
}
