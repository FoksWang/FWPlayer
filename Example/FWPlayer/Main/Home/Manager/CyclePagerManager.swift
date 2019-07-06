//
//  CyclePagerManager.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-06.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import TYCyclePagerView
import Then
import Kingfisher
import SnapKit

class CyclePagerManager: NSObject {
    
    private var data = [VideoModel]()
    private var parentView: UIView!
    
    private lazy var pagerView = TYCyclePagerView().then {
        $0.isInfiniteLoop = true
        $0.autoScrollInterval = 3.0
    }
    
    private lazy var pageControl = TYPageControl().then {
        $0.currentPageIndicatorSize = CGSize(width: 8, height: 8)
    }
    
    // Mark: -数据源更新
    typealias DidSelectedItemBlock = (_ videoModel: VideoModel) -> Void
    var didSelectedItemBlock: DidSelectedItemBlock?
    
    init(parentView: UIView, data: [VideoModel], didSelectedItemBlock: @escaping DidSelectedItemBlock) {
        super.init()
        
        self.parentView = parentView
        self.didSelectedItemBlock = didSelectedItemBlock
        
        self.addPagerView()
        self.addPageControl()
        self.loadData(data: data)
    }
    
    deinit {
    }
    
    private func addPagerView() {
        self.pagerView.layer.borderWidth = 1
        self.pagerView.dataSource = self
        self.pagerView.delegate = self
        self.pagerView.register(UINib(nibName: CyclePagerViewCell.className, bundle: nil), forCellWithReuseIdentifier: CyclePagerViewCell.reuseIdentifier)
        self.parentView.addSubview(pagerView)
    }
    
    private func addPageControl() {
        self.pagerView.addSubview(self.pageControl)
    }
    
    private func loadData(data: [VideoModel]) {
        self.data = data
        self.pageControl.numberOfPages = self.data.count
        self.pagerView.reloadData()
    }
    
    func viewWillLayoutSubviews() {
        self.pagerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.parentView)
            make.left.equalTo(self.parentView)
            make.right.equalTo(self.parentView)
            make.bottom.equalTo(self.parentView)
        }
        
        self.pageControl.snp.makeConstraints { (make) in
            make.left.equalTo(self.pagerView)
            make.right.equalTo(self.pagerView)
            make.bottom.equalTo(self.pagerView)
            make.height.equalTo(26)
        }
    }
}

extension CyclePagerManager: TYCyclePagerViewDelegate, TYCyclePagerViewDataSource {
    func numberOfItems(in pageView: TYCyclePagerView) -> Int {
        return self.data.count
    }
    
    func pagerView(_ pagerView: TYCyclePagerView, cellForItemAt index: Int) -> UICollectionViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: CyclePagerViewCell.reuseIdentifier, for: index) as! CyclePagerViewCell
        Logging("index = \(index), data[index].imageUrl = \(data[index].imageUrl!)")
        cell.imageView.image = UIImage(named: data[index].imageUrl!)
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
        self.didSelectedItemBlock?(data[index])
    }
}
