//
//  UINavigationController+Extension.swift
//  eports
//
//  Created by bobo on 2024/4/3.
//  Copyright © 2024 com.e-ports.www. All rights reserved.
//

import Foundation
import UIKit


extension UINavigationController {
    func setNaviagtionBackgroundColor(color: UIColor = .white) {
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = color
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        } else {
            navigationBar.barTintColor = color //nav背景色 kColorBackgroundColor
            navigationBar.backgroundColor = color
        }
    }
    
    
    
    ///查找并跳转到该类型的vc,返回false则没找到
    @discardableResult
    func popToVC(_ theClass:AnyClass, action:(()->())? = nil, animated:Bool = true) -> Bool{
        let viewControllers = self.viewControllers
        guard viewControllers.count>0 else { return false }
            
        for vc in viewControllers {
            // also can: if String(describing: type(of: vc)) ==  String(describing:theClass) 判断字符串
            if type(of: vc) == theClass {
                if let actionA = action {
                    actionA()
                }
                self.popToViewController(vc, animated: animated)
                return true
            }
        }
        return false
    }
}
