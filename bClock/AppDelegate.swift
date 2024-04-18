//
//  AppDelegate.swift
//  bClock
//
//  Created by bobo on 2024/3/11.
//

import UIKit
import AVKit

struct EPCountrySectionModel: Codable {
     
    var initial: String?
    
    var countryVos: [EPCountryModel]?
}
 

struct EPCountryModel: Codable {
     
    /// 国家ID
    var id: String?
    
    /// 区号id
    var code: String?
    
    /// 国家英文名
    var name: String?
    
    /// 国家中文名
    var nameCn: String?
    
    /// 区号
    var phoneCode: String?
    
    var initial: String?
    
    /// 国旗地址
    var nationalFlagUrl: String?
    
    var url: String?
    
    var isOverseas: Bool?
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: BOHomeVC())
        window?.makeKeyAndVisible()
         
        NotificationManager.shared.registerLocalNotification()
        
        return true
    }
    
    func registerLocalNotification(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> () {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.badge, .alert, .sound]) { state, error in
            if state {
                
            }
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // 清除角标
        application.applicationIconBadgeNumber = 0
        
        // 清除所有通知消息
//        UNUserNotificationCenter.removeAllPendingNotificationRequests(<#T##self: UNUserNotificationCenter##UNUserNotificationCenter#>)
        
//        UIApplication.shared.cancelAllLocalNotifications()
        
    }
    
}

