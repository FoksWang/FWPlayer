//
//  SideMenuViewController.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-04.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SideMenuSwift

class SideMenuViewController: UIViewController {
    var nameArray = ["Home","About"]
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: SideMenuTableViewCell.className, bundle: nil), forCellReuseIdentifier: SideMenuTableViewCell.reuseIdentifier)
            tableView.separatorStyle = .none
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK:- Setup views
extension SideMenuViewController {
    private func setupUI() {
        setupSideMenu()
    }
    
    private func setupSideMenu() {
        sideMenuController?.cache(viewControllerGenerator: {
            UIStoryboard(name: "About", bundle: nil).instantiateViewController(withIdentifier: "AboutNavigationController")
        }, with: "1")
        
        sideMenuController?.delegate = self
    }
}



// MARK:- SideMenuControllerDelegate
extension SideMenuViewController: SideMenuControllerDelegate {
    func sideMenuController(_ sideMenuController: SideMenuController,
                            animationControllerFrom fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BasicTransitionAnimator(options: .transitionFlipFromLeft, duration: 1.0)
    }
    
    func sideMenuController(_ sideMenuController: SideMenuController, willShow viewController: UIViewController, animated: Bool) {
        Logging("View controller will show [\(viewController)]")
    }
    
    func sideMenuController(_ sideMenuController: SideMenuController, didShow viewController: UIViewController, animated: Bool) {
        Logging("View controller did show [\(viewController)]")
    }
    
    func sideMenuControllerWillHideMenu(_ sideMenuController: SideMenuController) {
        Logging("Menu will hide")
    }
    
    func sideMenuControllerDidHideMenu(_ sideMenuController: SideMenuController) {
        Logging("Menu did hide.")
    }
    
    func sideMenuControllerWillRevealMenu(_ sideMenuController: SideMenuController) {
        Logging("Menu will reveal.")
    }
    
    func sideMenuControllerDidRevealMenu(_ sideMenuController: SideMenuController) {
        Logging("Menu did reveal.")
    }
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.reuseIdentifier, for: indexPath) as! SideMenuTableViewCell
        
        let row = indexPath.row
        cell.nameLabel.text = nameArray[row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        sideMenuController?.setContentViewController(with: "\(row)", animated: false)
        sideMenuController?.hideMenu()
        
        if let identifier = sideMenuController?.currentCacheIdentifier() {
            Logging("View Controller Cache Identifier: \(identifier)")
        }
    }
}
