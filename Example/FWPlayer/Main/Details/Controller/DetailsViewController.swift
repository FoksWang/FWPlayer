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
    var viewModel = DetailsViewModel(currentIndex: 0, videoList: [VideoModel]())
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: DetailsPlayerCell.className, bundle: nil), forCellReuseIdentifier: DetailsPlayerCell.reuseIdentifier)
            tableView.register(UINib(nibName: DetailsVideoLandscapeCell.className, bundle: nil), forCellReuseIdentifier: DetailsVideoLandscapeCell.reuseIdentifier)
            tableView.separatorStyle = .none
            tableView.fw_scrollViewDidStopScrollCallback = { [weak self] indexPath in
                guard let self = self else { return }
                if self.player?.playingIndexPath == nil {
                    self.playTheVideoAtIndexPath(indexPath: indexPath, scrollToTop: false)
                }
            }
        }
    }
    
    private lazy var cancelBarButton = UIButton(type: .custom).then {
        let itemSize = 20
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
        let itemSize = 20
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
    private lazy var playerControlView = FWPlayerControlView()
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
        // The tag value of player must be set in the cell
        self.player = FWPlayerController(scrollView: self.tableView, playerManager: playerManager, containerViewTag: 100).then {
            $0.controlView = playerControlView
            // Allow autoplay on mobile networks
            $0.isWWANAutoPlay = true
            // Autoplay
            $0.shouldAutoPlay = false
            // 1.0 means: when completely disappeared
            $0.playerDisapperaPercent = 1.0
            // 0.0 means: At the beginning of the display
            $0.playerApperaPercent = 0.0
            
            $0.orientationWillChange = { [weak self] (player, isFullScreen) in
                guard let self = self else { return }
                self.setNeedsStatusBarAppearanceUpdate()
                UIViewController.attemptRotationToDeviceOrientation()
                self.tableView.scrollsToTop = !isFullScreen
            }
            
            $0.playerDidToEnd = { [weak self] asset in
                guard let self = self else { return }
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
        self.player?.playTheIndexPath(indexPath, scrollToTop: scrollToTop)
//        let layout: FWTableViewCellLayout =
        let videoModel = viewModel.videoList[indexPath.row]
        let image = UIImage(named: "image_placeholder_landscape")
        self.playerControlView.showTitle(videoModel.title, cover: image, fullScreenMode: .landscape)
//        self.playerControlView.showTitle(videoModel.title, coverURLString: videoModel.imageUrl, fullScreenMode: .landscape)
    }
}

// MARK:- Setup data
extension DetailsViewController {
    private func setupData() {
        var videoUrls = [URL]()
        for videoModel in viewModel.videoList {
            if videoModel.type == "local" {
                videoUrls.append(URL(fileURLWithPath: videoModel.videoUrl!))
            } else {
                videoUrls.append(URL(string: videoModel.videoUrl!)!)
            }
        }
        self.player?.assetURLs = videoUrls
        self.tableView.reloadData()
        self.tableView.fw_filterShouldPlayCellWhileScrolled { [weak self] (indexPath) in
            guard let self = self else { return }
            self.playTheVideoAtIndexPath(indexPath: indexPath, scrollToTop: false)
        }
    }
}

// MARK:- UIScrollViewDelegate,for smallFloatView
extension DetailsViewController: UIScrollViewDelegate {
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
        return viewModel.videoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 { // top cell
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailsPlayerCell.reuseIdentifier, for: indexPath) as! DetailsPlayerCell
            cell.delegate = self
            return cell
            
        } else { // bottom cells
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailsVideoLandscapeCell.reuseIdentifier, for: indexPath) as! DetailsVideoLandscapeCell
            cell.delegate = self
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 { // top cell
            return 650
        } else {
            return 400
        }
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

extension DetailsViewController: DetailsVideoLandscapeCellDelegate {
    func playVideoAtDetailsVideoLandscapeCell(indexPath: IndexPath) {
        Logging("playVideoAtDetailsVideoLandscapeCell click: \(indexPath)")
        self.playTheVideoAtIndexPath(indexPath: indexPath, scrollToTop: false)
    }
    
}
