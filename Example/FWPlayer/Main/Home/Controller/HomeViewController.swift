//
//  HomeViewController.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-04.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Then
import TYCyclePagerView

class HomeViewController: UIViewController {
    var viewModel = HomeViewModel()
    
    @IBOutlet weak var titleNavItem: UINavigationItem! {
        didSet {
            titleNavItem.titleView = titleImageView
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.collectionViewLayout = UICollectionViewFlowLayout.init()
            collectionView.register(HomeCyclePagerContainerCell.self, forCellWithReuseIdentifier: HomeCyclePagerContainerCell.reuseIdentifier)
        }
    }
    
    private lazy var titleImageView = UIImageView().then {
        let itemWidth = 53
        let itemHeight = 15
        $0.image = UIImage(named: "demo_logo")!.scaleToSize(size: CGSize(width: itemWidth, height: itemHeight))
        $0.frame = CGRect(x: 0, y: 0, width: itemWidth, height: itemHeight)
    }
    
    private lazy var leftBarButton = UIButton(type: .custom).then {
        let itemSize = 20
        let image = UIImage(named: "navigation_drawer_dark")
        $0.setImage(image!.scaleToSize(size: CGSize(width: itemSize, height: itemSize)), for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: itemSize, height: itemSize)
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        $0.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.sideMenuController?.revealMenu()
        }).disposed(by: rx.disposeBag)
    }
    
    private lazy var rightBarButton = UIButton(type: .custom).then {
        let itemSize = 20
        let image = UIImage(named: "search_dark")
        $0.setImage(image!.scaleToSize(size: CGSize(width: itemSize, height: itemSize)), for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: itemSize, height: itemSize)
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        $0.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            Logging("rightBarButton click")
        }).disposed(by: rx.disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
}

// MARK:- Setup views
extension HomeViewController {
    private func setupUI() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
    }
}

// MARK:- Setup data
extension HomeViewController {
    private func setupData() {
        viewModel.updateDataBlock = { [unowned self] in
            self.collectionView.reloadData()
        }
        viewModel.loadData()
    }
}

// MARK:- Navigation
extension HomeViewController {
    private func pushViewController(_ videoModel: VideoModel) {
        Logging("pushViewController")
    }
}

// MARK:- UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moduleType = viewModel.data[indexPath.section].first?.type
        switch moduleType {
        case "local":
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCyclePagerContainerCell.reuseIdentifier, for: indexPath) as! HomeCyclePagerContainerCell
//            cell.delegate = self
            Logging("cellForItemAt local")
        case "swedish":
            Logging("cellForItemAt swedish")
        case "live":
            Logging("cellForItemAt live")
        case "vod":
            Logging("cellForItemAt vod")
        default:
            Logging("Unknown type")
        }
        // temp
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCyclePagerContainerCell.reuseIdentifier, for: indexPath) as! HomeCyclePagerContainerCell
        cell.dataModel = viewModel.data.first
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Logging("didSelectItemAt: \(indexPath)")
    }
    
    // inner margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt(section: section)
    }
    
    // margin between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }
    
    // minimum line margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    // item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForFooterInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return viewModel.viewForSupplementaryElementOfKind(kind: kind, indexPath: indexPath)
    }
}

extension HomeViewController: HomeCyclePagerContainerCellDelegate {
    func cyclePagerViewClick(videoModel: VideoModel) {
        Logging("cyclePagerViewClick: \(videoModel.title ?? "N/A")")
    }
}
