//
//  HomeCyclePagerContainerCell.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-07.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import TYCyclePagerView
import Then
import SnapKit

protocol HomeCyclePagerContainerCellDelegate: NSObjectProtocol {
    func didSelectedCyclePagerViewCell(videoList: [VideoModel])
}

class HomeCyclePagerContainerCell: UICollectionViewCell {
    static let className = "HomeCyclePagerContainerCell"
    static let reuseIdentifier = className
    
    private var data = [VideoModel]()
    weak var delegate: HomeCyclePagerContainerCellDelegate?
    
    private lazy var pagerView = TYCyclePagerView().then {
        $0.isInfiniteLoop = true
        $0.autoScrollInterval = 4.0
        $0.dataSource = self
        $0.delegate = self
        $0.register(UINib(nibName: HomeCyclePagerViewCell.className, bundle: nil), forCellWithReuseIdentifier: HomeCyclePagerViewCell.reuseIdentifier)
    }
    
    private lazy var pageControl = TYPageControl().then {
        $0.currentPageIndicatorSize = CGSize(width: 8, height: 8)
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
            self.pageControl.numberOfPages = self.data.count
            self.pagerView.reloadData()
        }
    }
    
    private func setupUI() {
        self.addPagerView()
        self.addPageControl()
    }
    
    private func addPagerView() {
        self.addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    private func addPageControl() {
        self.pagerView.addSubview(self.pageControl)
        
        self.pageControl.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.pagerView)
            make.height.equalTo(26)
        }
    }
}

extension HomeCyclePagerContainerCell: TYCyclePagerViewDelegate, TYCyclePagerViewDataSource {
    func numberOfItems(in pageView: TYCyclePagerView) -> Int {
        return self.data.count
    }
    
    func pagerView(_ pagerView: TYCyclePagerView, cellForItemAt index: Int) -> UICollectionViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: HomeCyclePagerViewCell.reuseIdentifier, for: index) as! HomeCyclePagerViewCell
        cell.imageView.image = UIImage(named: data[index].imageLandscapeUrl!)
        return cell
    }
    
    func layout(for pageView: TYCyclePagerView) -> TYCyclePagerViewLayout {
        let layout = TYCyclePagerViewLayout()
        layout.itemSize = CGSize(width: self.pagerView.frame.width, height: self.pagerView.frame.height)
        layout.itemSpacing = 0
        layout.itemHorizontalCenter = true
        return layout
    }
    
    func pagerView(_ pageView: TYCyclePagerView, didScrollFrom fromIndex: Int, to toIndex: Int) {
        self.pageControl.currentPage = toIndex;
    }
    
    func pagerView(_ pageView: TYCyclePagerView, didSelectedItemCell cell: UICollectionViewCell, at index: Int) {
        let videoModel = data.remove(at: index)
        data.insert(videoModel, at: 0)
        self.delegate?.didSelectedCyclePagerViewCell(videoList: data)
    }
}

