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

class DetailsViewController: UIViewController {
    var viewModel = DetailsViewModel(currentIndex: 0, videoList: [VideoModel]())
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: DetailsPlayerCell.className, bundle: nil), forCellReuseIdentifier: DetailsPlayerCell.reuseIdentifier)
            tableView.register(UINib(nibName: DetailsVideoLandscapeCell.className, bundle: nil), forCellReuseIdentifier: DetailsVideoLandscapeCell.reuseIdentifier)
            tableView.separatorStyle = .none
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
    func playVideoAtDetailsPlayerCell(currentIndex: Int) {
        //
    }
    
}

extension DetailsViewController: DetailsVideoLandscapeCellDelegate {
    func playVideoAtDetailsVideoLandscapeCell(currentIndex: Int) {
        //
    }
    
}
