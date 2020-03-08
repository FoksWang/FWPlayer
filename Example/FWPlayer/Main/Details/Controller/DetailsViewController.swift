//
//  DetailsViewController.swift
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
import FWPlayerCore

class DetailsViewController: UIViewController {
    var viewModel = DetailsViewModel(videoList: [VideoModel]())
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: DetailsPlayerCell.className, bundle: nil), forCellReuseIdentifier: DetailsPlayerCell.reuseIdentifier)
            tableView.separatorStyle = .none
            
            tableView.fw_scrollViewDidStopScrollCallback = { [unowned self] indexPath in
                if self.player?.playingIndexPath == nil {
                    self.playTheVideoAtIndexPath(indexPath: indexPath, scrollToTop: false)
                }
            }
        }
    }
    
    private lazy var cancelBarButton = UIButton(type: .custom).then {
        let itemSize = 24
        let image = UIImage(named: "close")
        $0.setImage(image!.scaleToSize(size: CGSize(width: itemSize, height: itemSize)), for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: itemSize, height: itemSize)
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        $0.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: rx.disposeBag)
    }
    
    private lazy var castBarButton = UIButton(type: .custom).then {
        let itemSize = 24
        let image = UIImage(named: "cast_light")
        $0.setImage(image!.scaleToSize(size: CGSize(width: itemSize, height: itemSize)), for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: itemSize, height: itemSize)
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        $0.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            NotificationCenter.default.post(name: notificationNameShowMessage, object: "No such function at the moment")
        }).disposed(by: rx.disposeBag)
    }
    
    private lazy var playerManager = FWAVPlayerManager()
    private lazy var playerControlView = FWPlayerControlView().then {
        $0.fastViewAnimated = true
        $0.autoHiddenTimeInterval = 5.0
        $0.autoFadeTimeInterval = 0.5
        $0.prepareShowLoading = true
        $0.prepareShowControlView = true
    }
    
    private var player: FWPlayerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPlayer()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.player?.isViewControllerDisappear = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.player?.isViewControllerDisappear = true
    }
    
    override func willMove(toParent parent: UIViewController?) {
        guard let _ = parent else {
            self.tableView.delegate = nil
            self.player?.stopCurrentPlayingCell()
            return
        }
    }
    
    override var shouldAutorotate: Bool {
        return self.player?.shouldAutorotate ?? false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if self.player?.isFullScreen ?? false && self.player?.orientationObserver.fullScreenMode == .landscape {
            return .landscape
        }
        return .portrait;
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if self.player?.isFullScreen ?? false {
            return .lightContent
        }
        return .default
    }
    
    /// Return 'false' directly if the app only supports iOS9+, otherwise, write: return self.player.isStatusBarHidden
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}

// MARK:- Setup views
extension DetailsViewController {
    private func setupUI() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelBarButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: castBarButton)
        self.setupShowMessage()
    }
}

// MARK:- Setup player
extension DetailsViewController {
    private func setupPlayer() {
        // Enable media cache for assets
        self.playerManager.isEnableMediaCache = viewModel.isTypeAssets()
        Logging("isEnableMediaCache = \(self.playerManager.isEnableMediaCache)")
        
        // The tag value of player must be set in the cell
        self.player = FWPlayerController(scrollView: self.tableView, playerManager: playerManager, containerViewTag: 100).then {
            $0.controlView = playerControlView
            // Allow autoplay on mobile networks
            $0.isWWANAutoPlay = true
            // Autoplay is smallFloatView
            $0.shouldAutoPlay = true
            // 1.0 means: when completely disappeared
            $0.playerDisapperaPercent = 1.0
            // 0.0 means: At the beginning of the display
            $0.playerApperaPercent = 0.0
            
            $0.orientationWillChange = { [unowned self] (player, isFullScreen) in
                self.setNeedsStatusBarAppearanceUpdate()
                UIViewController.attemptRotationToDeviceOrientation()
                self.tableView.scrollsToTop = !isFullScreen
            }
            
            $0.playerDidToEnd = { [unowned self] asset in
                self.playerControlView.resetControlView()
                self.player?.stopCurrentPlayingCell()
            }
            
            // Slide out of the screen without stopping the playback
            $0.stopWhileNotVisible = false
            
            let margin: CGFloat = 20
            let w: CGFloat = fwScreenWidth / 2
            let h: CGFloat = w * 9 / 16
            let x: CGFloat = fwScreenWidth - w - margin
            let y: CGFloat = fwScreenHeight - h - margin
            $0.smallFloatView.frame = CGRect(x: x, y: y, width: w, height: h)
        }
    }
    
    /// play the video
    private func playTheVideoAtIndexPath(indexPath: IndexPath, scrollToTop: Bool) {
        self.player?.stopCurrentPlayingCell()
        self.player?.playTheIndexPath(indexPath, scrollToTop: scrollToTop)
        let videoModel = viewModel.getVideoModel(indexPath: indexPath)
        let image = UIImage(named: "cover_image_placeholder")
        self.playerControlView.showTitle(videoModel.title, cover: image, fullScreenMode: .landscape)
        //        self.playerControlView.showTitle(videoModel.title, coverURLString: videoModel.imageUrl, fullScreenMode: .landscape)
    }
}

// MARK:- Setup data
extension DetailsViewController {
    private func setupData() {
        viewModel.updateDataBlock = { [unowned self] (videoUrls) in
            self.player?.assetURLs = videoUrls
            self.tableView.reloadData()
            self.tableView.fw_filterShouldPlayCellWhileScrolled { [unowned self] (indexPath) in
                self.playTheVideoAtIndexPath(indexPath: indexPath, scrollToTop: false)
            }
        }
        viewModel.loadData()
    }
}

// MARK:- To enable smallFloatView must implement UIScrollViewDelegate
extension DetailsViewController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.fw_scrollViewDidEndDecelerating()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.fw_scrollViewDidEndDraggingWillDecelerate(decelerate)
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        scrollView.fw_scrollViewDidScrollToTop()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.fw_scrollViewDidScroll()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.fw_scrollViewWillBeginDragging()
    }
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsPlayerCell.reuseIdentifier, for: indexPath) as! DetailsPlayerCell
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        indexPath.row == 0 ? cell.showAdditionInfoView() : cell.hideAdditionInfoView()
        viewModel.isLastItem(indexPath: indexPath) ? cell.hideBottomBlackView() : cell.showBottomBlackView()
        
        let videoModel = viewModel.getVideoModel(indexPath: indexPath)
        if videoModel.type == "local" {
            cell.coverImageView.setImageWithURLString(videoModel.imageLandscapeUrl, placeholderImageName: videoModel.imageLandscapeUrl)
        } else {
            cell.coverImageView.setImageWithURLString(videoModel.imageLandscapeUrl, placeholderImageName: "cover_image_placeholder")
        }
        
        cell.videoTitleLabel.text = videoModel.title?.capitalized
        cell.videoTypeLabel.text = videoModel.type?.capitalized
        cell.videoDescTextView.text = videoModel.description?.capitalized
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension DetailsViewController: DetailsPlayerCellDelegate {
    func playVideoAtDetailsPlayerCell(indexPath: IndexPath) {
        Logging("playVideoAtDetailsPlayerCell click: \(indexPath)")
        self.playTheVideoAtIndexPath(indexPath: indexPath, scrollToTop: false)
    }
}

