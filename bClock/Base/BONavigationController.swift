//
//  BONavigationController.swift
//  bClock
//
//  Created by bobo on 2024/3/11.
//

import UIKit

class BONavigationController: UINavigationController {
    var bottomLine:UIView?
    
    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.barTintColor = AppColor.WeightBlack
        
        navigationBar.tintColor = .white
        navigationBar.backgroundColor = .white
         
        //底部线
        let bottomLine = UIView()
        bottomLine.backgroundColor = AppColor.LineColor
        self.navigationBar.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(kScreenWidth)
//            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        self.bottomLine = bottomLine
        
//        let statusView = UIView()
//        statusView.backgroundColor = .white
//        navigationBar.addSubview(statusView)
//        statusView.frame = .init(x: 0, y: -20-safeAreaTop(), width: kScreenWidth, height: 20 + safeAreaTop())
        
        // 设置阴影图片
//        if self.navigationBar.responds(to: #selector(setter: UINavigationBar.shadowImage)) {
//            self.navigationBar.shadowImage = UIImage()
//        }
//        if self.navigationBar.responds(to: #selector(setter: UINavigationBar.backIndicatorImage)) {
//            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        }
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.viewControllers.count > 0 {
            let back = UIBarButtonItem.init(image: UIImage.init(named: Pic.Base.Back)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(clickBack))
            viewController.navigationItem.leftBarButtonItem = back
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
        interactivePopGestureRecognizer?.delegate = nil
    }
    
    
    @objc
    private func clickBack() -> () {
        self.popViewController(animated: true)
    }
}
