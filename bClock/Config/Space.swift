//
//  Space.swift
//  bClock
//
//  Created by bobo on 2024/3/11.
//

import UIKit

// MARK: - 间距Space -
let kScreenWidth = UIScreen.main.bounds.width

let kScreenHeight = UIScreen.main.bounds.height

let pt = UIScreen.main.bounds.width / 375.0

//StatusBar Height
var kStatusBarHeight: CGFloat {
    var statusBarHeight = 0.0
    if #available(iOS 13.0, *){
        let statusBarManager:UIStatusBarManager = UIApplication.shared.windows.first!.windowScene!.statusBarManager!
        statusBarHeight = Double(Int(statusBarManager.statusBarFrame.size.height));
    }
    else {
        statusBarHeight = Double(UIApplication.shared.statusBarFrame.size.height);
    }
    return statusBarHeight
}

func safeAreaTop() -> CGFloat {
    if #available(iOS 11.0, *) {
        //iOS 12.0以后的非刘海手机top为 20.0
        if (UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets.bottom == 0 {
            return 20.0
        }
        return (UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets.top ?? 20.0
    }
    return 20.0
}

func safeAreaBottom() -> CGFloat {
    if #available(iOS 11.0, *) {
        return (UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets.bottom ?? 0
    }
    return 0
}


func safeBottom() -> CGFloat {
    if #available(iOS 11.0, *) {
        return ((UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets.bottom ?? 0) * 0.5
    }
    return 0
}

func hasSafeArea() -> Bool {
    if #available(iOS 11.0, *) {
        return (UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets.bottom ?? CGFloat(0) > CGFloat(0)
    } else { return false }
}

func toolBarHeight() -> CGFloat {
    return 49 + safeAreaBottom()
}

func navigationHeight() -> CGFloat {
    return 44 + safeAreaTop()
}
