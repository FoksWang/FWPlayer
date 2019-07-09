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
            
            // register header view and footer view
            collectionView.register(HomeVideosHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeVideosHeaderView.reuseIdentifier)
            collectionView.register(HomeVideosFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeVideosFooterView.reuseIdentifier)
            
            // register cells
            collectionView.register(HomeCyclePagerContainerCell.self, forCellWithReuseIdentifier: HomeCyclePagerContainerCell.reuseIdentifier)
            collectionView.register(HomeVideoPortraitContainerCell.self, forCellWithReuseIdentifier: HomeVideoPortraitContainerCell.reuseIdentifier)
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
    
    private lazy var castBarButton = UIButton(type: .custom).then {
        let itemSize = 20
        let image = UIImage(named: "cast_dark")
        $0.setImage(image!.scaleToSize(size: CGSize(width: itemSize, height: itemSize)), for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: itemSize, height: itemSize)
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        $0.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            NotificationCenter.default.post(name: notificationNameShowMessage, object: "No such function at the moment")
        }).disposed(by: rx.disposeBag)
    }
    
    private lazy var searchBarButton = UIButton(type: .custom).then {
        let itemSize = 20
        let image = UIImage(named: "search_dark")
        $0.setImage(image!.scaleToSize(size: CGSize(width: itemSize, height: itemSize)), for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: itemSize, height: itemSize)
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        $0.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            NotificationCenter.default.post(name: notificationNameShowMessage, object: "No such function at the moment")
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
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: castBarButton), UIBarButtonItem(customView: searchBarButton)]
        self.setupShowMessage()
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

// MARK:- UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let key = viewModel.homeVideoList.displayIndex[indexPath.section]
        let moduleType = viewModel.homeVideoList.videos[key]?.first?.type
        
        if moduleType == "local" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCyclePagerContainerCell.reuseIdentifier, for: indexPath) as! HomeCyclePagerContainerCell
            cell.dataModel = viewModel.homeVideoList.videos[key]
            cell.delegate = self
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeVideoPortraitContainerCell.reuseIdentifier, for: indexPath) as! HomeVideoPortraitContainerCell
            cell.dataModel = viewModel.homeVideoList.videos[key]
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
        return viewModel.viewForSupplementaryElementOfKind(collectionView, kind: kind, indexPath: indexPath)
    }
}

extension HomeViewController: HomeCyclePagerContainerCellDelegate {
    func didSelectedCyclePagerViewCell(currentIndex: Int, videoList: [VideoModel]) {
        Logging("didSelectedCyclePagerViewCell: \(videoList[currentIndex].title ?? "N/A")")
        let viewModel = DetailsViewModel(currentIndex: currentIndex, videoList: videoList)
        let navigationController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "DetailsNavigationController") as! UINavigationController
        let viewController = navigationController.topViewController as! DetailsViewController
        viewController.viewModel = viewModel
        self.present(navigationController, animated: true, completion: nil)
    }
}

extension HomeViewController: HomeVideoPortraitContainerCellDelegate {
    func didSelectedVideoPortraitCell(currentIndex: Int, videoList: [VideoModel]) {
        Logging("didSelectedVideoPortraitCell: \(videoList[currentIndex].title ?? "N/A")")
        let viewModel = DetailsViewModel(currentIndex: currentIndex, videoList: videoList)
    }
}
