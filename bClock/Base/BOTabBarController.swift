//
//  BOTabBarController.swift
//  bClock
//
//  Created by bobo on 2024/3/11.
//

import UIKit

class BOTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = AppColor.MainColor
        self.tabBar.unselectedItemTintColor = UIColor.black.withAlphaComponent(0.43)
        
        addSubController(vc: BOHomeVC(), imageName: "", title: "Home")
        addSubController(vc: BOMineVC(), imageName: "", title: "Mine")
    }
    
    
    ///   添加子控制器
    /// - Parameters:
    ///   - vc: 子控制器对象
    ///   - imageName: 图片名
    ///   - title: 标题
    func addSubController(vc: UIViewController, imageName: String, title: String) {
        let ctrl = BONavigationController.init(rootViewController: vc)
        ctrl.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: kRegularFont(17)]
  
        ctrl.tabBarItem.title = title
        ctrl.tabBarItem.image = UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
        let selectedImg = UIImage.init(named: "\(imageName)_selected")?.withRenderingMode(.alwaysOriginal)
        ctrl.tabBarItem.selectedImage = selectedImg
        if #available(iOS 10.0, *) {
            ctrl.tabBarItem.setBadgeTextAttributes([NSAttributedString.Key.font : kMediumFont(12)], for: .normal)
            ctrl.tabBarItem.badgeColor = AppColor.BadgeColor
        } else {
            // Fallback on earlier versions
        }
//        ctrl.tabBarItem.imageInsets = .init(top: 7, left: 0, bottom: -7, right: 0)
        addChild(ctrl)
    }
}
