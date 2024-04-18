//
//  NotificationManager.swift
//  bClock
//
//  Created by bobo on 2024/4/10.
//

import Foundation
import UserNotifications

// 时间格式
let formateString = "yyyyMMddhhmmss"

/// 延后标识符
let categryLaterIdf = "categryIdentifierLater"
// 停止标识符
let categryStopIdf = "categryIdentifierStop"


let UNDidReciveRemoteNotifationKey = "UNDidReciveRemateNotifationKey"
let UNDidReciveLocalNotifationKey = "UNDidReciveLocalNotifationKey"
let UNNotifationInfoIdentiferKey = "UNNotifationInfoIdentiferKey"

let actionFiveMin = "fiveMinete"
let actionHalfAnHour = "halfAnHour"
let actionOneHour = "oneHour"
let actionStop = "stopCancel"
 
/// 本地通知单例
open class NotificationManager: NSObject {
    
    /// 单例对象
    static let shared = NotificationManager()
    

    /// 初始化信号量为1
    let semaphore = DispatchSemaphore(value: 1)
    
    /// 通知中心
    lazy var center: UNUserNotificationCenter = {
        return UNUserNotificationCenter.current()
    }()
    
    /// 日历对象
    static var calendar: Calendar = {
        var c = Calendar.init(identifier: .gregorian)
        c.timeZone = TimeZone.current
        return c
    }()
}

// MARK: 添加通知操作
extension NotificationManager {
    
    
    /// 创建推送消息
    /// - Parameters:
    ///   - body: 推送消息体
    ///   - title: 推送消息标题
    ///   - subTitle: 推送消息副标题
    ///   - components: 推送消息触发时间组
    ///   - soundName: 铃声名称
    ///   - identifier: 推送消息标识符
    ///   - isRepeat: 是否重复
    ///   - handler: 处理回调
    static func addComponentsNotificationWithBody(body: String, title: String, subTitle: String, components: DateComponents, soundName: String, identifier: String, isRepeat: Bool, handler: @escaping (_ error: Error?) -> ()) {
        let content = contentWith(title: title, subTitle: subTitle, body: body, sound: soundWithName(soundName))
        addNotificationWithContent(content: content, components: components, identifier: identifier, isRepeat: isRepeat, handler: handler)
    }
    
    
    /// 创建每日重复推送
    /// - Parameters:
    ///   - body: 推送消息体
    ///   - title: 推送消息标题
    ///   - subTitle: 推送消息副标题
    ///   - date: 推送消息的日期
    ///   - soundName: 推送消息铃声名称
    ///   - identifier: 推送消息标识符
    ///   - isRepeat: 是否重复
    ///   - handler: 处理回调
    static func addRepeatEveryDayNotificationWithBody(body: String, title: String, subTitle: String, date: Date, soundName: String, identifier: String, isRepeat: Bool, handler: @escaping (_ error: Error?) -> ()) {
        let content = contentWith(title: title, subTitle: subTitle, body: body, sound: soundWithName(soundName))
        addNotificationWithContent(content: content, components: componentsEveryDayWithDate(date), identifier: identifier, isRepeat: isRepeat, handler: handler)
    }
    
    /// 创建推送
    /// - Parameters:
    ///   - body: 推送消息体
    ///   - title: 推送消息标题
    ///   - subTitle: 推送消息副标题
    ///   - weekDay: 周几
    ///   - date: 推送消息的日期
    ///   - soundName: 推送消息铃声名称
    ///   - identifier: 推送消息标识符
    ///   - isRepeat: 是否重复
    ///   - handler: 处理回调
    static func addNotificationWithBody(body: String, title: String, subTitle: String, weekDay: Int, date: Date, soundName: String, identifier: String, isRepeat: Bool, handler: @escaping (_ error: Error?) -> ()) {
        let content = contentWith(title: title, subTitle: subTitle, body: body, sound: soundWithName(soundName))
        addNotificationWithContent(content: content, weekDay: weekDay, date: date, identifier: identifier, isRepeat: isRepeat, handler: handler)
    }
    
    /// 创建推送
    /// - Parameters:
    ///   - content: 推送消息内容
    ///   - weekDay: 周几
    ///   - date: 推送消息的日期
    ///   - identifier: 推送消息标识符
    ///   - isRepeat: 是否重复
    ///   - handler: 处理回调
    static func addNotificationWithContent(content: UNNotificationContent, weekDay: Int, date: Date, identifier: String, isRepeat: Bool, handler: @escaping (_ error: Error?) -> ()) {
        addNotificationWithContent(content: content, components: componentsWithDate(date, weekDay), identifier: identifier, isRepeat: isRepeat, handler: handler)
    }
    
    /// 创建推送
    /// - Parameters:
    ///   - content: 推送消息内容
    ///   - interval: 经过一段时间后推送
    ///   - identifier: 推送消息标识符
    ///   - isRepeat: 是否重复
    ///   - handler: 处理回调
    static func addNotificationWithContent(content: UNNotificationContent, interval: TimeInterval, identifier: String, isRepeat: Bool, handler: @escaping (_ error: Error?) -> ()) {
        addNotificationWithContent(content: content, identifier: identifier, trigger: triggerWithTimeInterval(timeInterval: interval, repeats: isRepeat), handler: handler)
    }
    
    /// 创建推送
    /// - Parameters:
    ///   - content: 推送消息内容
    ///   - components: 推送的时间组成
    ///   - identifier: 推送消息标识符
    ///   - isRepeat: 是否重复
    ///   - handler: 处理回调
    static func addNotificationWithContent(content: UNNotificationContent, components: DateComponents, identifier: String, isRepeat: Bool, handler: @escaping (_ error: Error?) -> ()) {
        addNotificationWithContent(content: content, identifier: identifier, trigger: triggerWithDateComponents(components: components, repeats: isRepeat), handler: handler)
    }
    
    
    /// 创建推送
    /// - Parameters:
    ///   - content: 推送消息内容
    ///   - identifier: 推送消息标识符
    ///   - trigger: 触发器
    ///   - handler: 处理回调
    static func addNotificationWithContent(content: UNNotificationContent, identifier: String, trigger: UNNotificationTrigger, handler: @escaping (_ error: Error?) -> ()) {
        guard let newContent = content.mutableCopy() as? UNMutableNotificationContent else {
            return
        }
        newContent.categoryIdentifier = categryLaterIdf
        addNotificationWithRequest(request: UNNotificationRequest(identifier: identifier, content: newContent, trigger: trigger), handler: handler)
    }
    
    /// 创建推送
    /// - Parameters:
    ///   - request: 推送请求
    ///   - handler: 处理回调
    static func addNotificationWithRequest(request: UNNotificationRequest, handler: @escaping (_ error: Error?) -> ()) {
        NotificationManager.shared.addNotificationWithRequest(request: request, handler: handler)
    }
    
    /// 创建推送
    /// - Parameters:
    ///   - request: 推送请求
    ///   - handler: 处理回调
    private func addNotificationWithRequest(request: UNNotificationRequest, handler: @escaping (_ error: Error?) -> ()) {
        DispatchQueue(label: "curQueue").async {
            self.semaphore.wait()
            
            self.getAllNotificationIdentiferBlock { identifiers in
                if (identifiers.count >= 64) {
                    self.semaphore.signal()
                    return
                }
                self.center.add(request) { error in
                    self.semaphore.signal()
                    handler(error)
                }
            }
        }
    }
}

// MARK: 获取通知相关
extension NotificationManager {
    
    /// 获取挂起的通知
    /// - Parameter idBlock: 标识符回调
    final func getPendingNotificationIdentiferBlock(idBlock: @escaping (_ identifiers: [String])-> ()) {
        var array = [String]()
        center.getPendingNotificationRequests { requests in
            for e in requests {
                array.append(e.identifier)
            }
            idBlock(array)
        }
    }
    
    
    /// 获取所有发送的通知
    /// - Parameter idBlock: 标识符回调
    final func getDeliveredNotificationIdentiferBlock(idBlock: @escaping (_ identifiers: [String])-> ()) {
        var array = [String]()
        center.getDeliveredNotifications { notifications in
            for e in notifications {
                array.append(e.request.identifier)
            }
            idBlock(array)
        }
    }
    
    /// 标识对应的通知是否存在
    /// - Parameters:
    ///   - identifier: 通知的标识符
    ///   - completion: 结果
    final func notificationIsExitWithIdentifer(identifier: String, completion: @escaping (_ result: Bool) -> ()){
        getAllNotificationIdentiferBlock { identifiers in
            for e in identifiers {
                if e == identifier {
                    completion(true)
                    return
                }
            }
            completion(false)
        }
    }
    
    /// 获取所有通知
    /// - Parameter idBlock: 通知标识符数组的回调
    final func getAllNotificationIdentiferBlock(idBlock: @escaping (_ identifiers: [String])-> ()) {
        var array = [String]()
        center.getDeliveredNotifications { notifications in
            for e in notifications {
                array.append(e.request.identifier)
            }
            
            self.center.getPendingNotificationRequests { requests in
                for e in requests {
                    array.append(e.identifier)
                }
                idBlock(array)
            }
        }
    }
    
}

// MARK: 移除本地通知
extension NotificationManager {
    /// 根据通知标识符数组删除指定通知
    /// - Parameter identifier: 通知标识符数组
    final func removeNotificationWithIdentifiers(_ identifiers: [String]) {
        // 移除所有已经送达的通知
        center.removeDeliveredNotifications(withIdentifiers: identifiers)
        // 删除所有挂起的通知请求
        center.removeDeliveredNotifications(withIdentifiers: identifiers)
    }
    
    /// 根据通知标识符删除指定通知
    /// - Parameter identifier: 通知标识符
    final func removeNotificationWithIdentifier(_ identifier: String) {
        // 移除所有已经送达的通知
        center.removeDeliveredNotifications(withIdentifiers: [identifier])
        // 删除所有挂起的通知请求
        center.removeDeliveredNotifications(withIdentifiers: [identifier])
    }
    
    /// 移除所有本地通知
    final func removeAllNotification() {
        // 移除所有已经送达的通知
        center.removeAllDeliveredNotifications()
        // 删除所有挂起的通知请求
        center.removeAllPendingNotificationRequests()
    }
}

// MARK: 注册本地通知
extension NotificationManager {
    
    /// 注册本地通知
    /// - Parameter options: 通知响应选项
    final func registerLocalNotification(_ options: UNAuthorizationOptions = [.alert, .sound]) {
        
        /// 设置响应mode
        center.requestAuthorization(options: options) { status, error in
            if error != nil {
                debugPrint(error.debugDescription)
            }
        }
        center.getNotificationSettings { settings in
            debugPrint(settings)
        }
        
        // 设置通知操作列表
        let actionMaps = [[actionStop: "停止"], [actionFiveMin: "5分钟后"], [actionHalfAnHour: "半小时后"], [actionOneHour: "1小时后"]]
        var actions = [UNNotificationAction]()
        for actionMap in actionMaps {
            let action = UNNotificationAction.init(identifier: actionMap.keys.first ?? "", title: actionMap.values.first ?? "")
            actions.append(action)
        }
        let category = UNNotificationCategory.init(identifier: categryLaterIdf, actions: actions, intentIdentifiers: [], options: [])
        
        let lastMap = actionMaps.last ?? ["": ""]
        let stopAction =  UNNotificationAction.init(identifier: lastMap.keys.first ?? "", title: lastMap.values.first ?? "")
        let stopCategory = UNNotificationCategory.init(identifier: categryStopIdf, actions: [stopAction], intentIdentifiers: [], options: [])
        center.setNotificationCategories(Set.init([category, stopCategory]))
        UNUserNotificationCenter.current().delegate = NotificationManager.shared
    }
    
}

// MARK: UNUserNotificationCenterDelegate
extension NotificationManager: UNUserNotificationCenterDelegate{
    
    /// 通知将要展示的处理
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self) == true { // 接受远程通知
            let userInfo = notification.request.content.userInfo
            NotificationCenter.default.post(name:  NSNotification.Name(rawValue: UNDidReciveRemoteNotifationKey), object: nil, userInfo: userInfo)
        } else {
            NotificationCenter.default.post(name:  NSNotification.Name(rawValue: UNDidReciveLocalNotifationKey), object: nil, userInfo: [UNNotifationInfoIdentiferKey: notification.request.identifier])
        }
        completionHandler([.alert, .sound, .badge])
    }
    
    /// 推送成功接收的处理
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self) == true {
            let userInfo = response.notification.request.content.userInfo
            NotificationCenter.default.post(name:  NSNotification.Name(rawValue: UNDidReciveRemoteNotifationKey), object: nil, userInfo: userInfo)
        } else {
            handCommnet(response: response)
        }
        
        completionHandler()
    }
    
    
    /// 处理用户接收通知后的操作
    /// - Parameter response: 用户响应的操作
    func handCommnet(response: UNNotificationResponse) {
        let actionIdef = response.actionIdentifier
        var date: Date?
        if actionIdef == actionStop {
            return
        } else if actionIdef == actionFiveMin {
            date = Date.init(timeIntervalSinceNow: 5 * 60)
        } else if actionIdef == actionHalfAnHour {
            date = Date.init(timeIntervalSinceNow: 30 * 60)
        } else if actionIdef == actionOneHour {
            date = Date.init(timeIntervalSinceNow: 60 * 60)
        }
        
        guard let d = date else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: UNDidReciveLocalNotifationKey), object: nil, userInfo: [UNDidReciveLocalNotifationKey: response.notification.request.identifier])
            return
        }
        
        let format = DateFormatter()
        format.dateFormat = formateString
        let identifer = format.string(from: d)
        NotificationManager.addNotificationWithContent(content: response.notification.request.content, identifier: identifer, trigger: NotificationManager.triggerWithDateComponents(components: NotificationManager.componentsWithDate(date ?? Date()), repeats: false)) { error in
            if error != nil {
                debugPrint("fail")
            } else {
                debugPrint("success")
            }
        }
    }
}

// MARK: 日期拆分成组件
extension NotificationManager {
    
    /// 日期拆解为:年,月,日,时,分
    /// - Parameter date: 日期
    /// - Returns: 日期组成
    static func componentsWithDate(_ date: Date) -> DateComponents {
        return calendar.dateComponents([Calendar.Component.year, Calendar.Component.month, Calendar.Component.day, Calendar.Component.hour, Calendar.Component.minute], from: date)
    }
    
    
    /// 指定周的时,分
    /// - Parameters:
    ///   - date: 日期
    ///   - weekday: 周
    /// - Returns: 日期组成
    static func componentsWithDate(_ date: Date, _ weekday: Int) -> DateComponents {
        var components = calendar.dateComponents([Calendar.Component.hour, Calendar.Component.minute], from: date)
        components.weekday = weekday
        return components
    }
    
    
    /// 每天重复
    /// - Parameter date: 日期
    /// - Returns: DateComponents
    static func componentsEveryDayWithDate(_ date: Date) -> DateComponents {
        return calendar.dateComponents([Calendar.Component.hour, Calendar.Component.minute], from: date)
    }
    
    /// 每周重复
    /// - Parameter date: 日期
    /// - Returns: DateComponents
    static func componentsEveryWeekWithDate(_ date: Date) -> DateComponents {
        return calendar.dateComponents([Calendar.Component.weekday, Calendar.Component.hour, Calendar.Component.minute], from: date)
    }
    
    /// 每月重复
    /// - Parameter date: 日期
    /// - Returns: DateComponents
    static func componentsEveryMonthWithDate(_ date: Date) -> DateComponents {
        return calendar.dateComponents([Calendar.Component.day, Calendar.Component.hour, Calendar.Component.minute], from: date)
    }
    
    /// 每年重复
    /// - Parameter date: 日期
    /// - Returns: DateComponents
    static func componentsEveryYearWithDate(_ date: Date) -> DateComponents {
        return calendar.dateComponents([Calendar.Component.month, Calendar.Component.day, Calendar.Component.hour, Calendar.Component.minute], from: date)
    }
}

// MARK: 创建通知内容
extension NotificationManager {
    
    static func contentWith(title: String, subTitle: String, body: String, badge: Int, sound: UNNotificationSound, attachments: [UNNotificationAttachment]) -> UNMutableNotificationContent {
        let content = contentWith(title: title, subTitle: subTitle, body: body)
        content.badge = NSNumber.init(value: UInt(badge))
        content.sound = sound
        content.attachments = attachments
        return content
    }
    
    static func contentWith(title: String, subTitle: String, body: String, badge: Int, sound: UNNotificationSound, attachment: UNNotificationAttachment) -> UNMutableNotificationContent {
        let content = contentWith(title: title, subTitle: subTitle, body: body)
        content.badge = NSNumber.init(value: UInt(badge))
        content.sound = sound
        content.attachments = [attachment]
        return content
    }
    
    static func contentWith(title: String, subTitle: String, body: String, badge: Int, sound: UNNotificationSound) -> UNMutableNotificationContent {
        let content = contentWith(title: title, subTitle: subTitle, body: body)
        content.badge = NSNumber.init(value: UInt(badge))
        content.sound = sound
        return content
    }
    
    static func contentWith(title: String, subTitle: String, body: String, sound: UNNotificationSound) -> UNMutableNotificationContent {
        let content = contentWith(title: title, subTitle: subTitle, body: body)
        content.sound = sound
        return content
    }
    
    static func contentWith(title: String, subTitle: String, body: String, badge: Int) -> UNMutableNotificationContent {
        let content = contentWith(title: title, subTitle: subTitle, body: body)
        content.badge = NSNumber.init(value: UInt(badge))
        return content
    }
    
    static func contentWith(title: String, subTitle: String, body: String) -> UNMutableNotificationContent {
        let titleStr = title.isEmpty ? "闹钟" : title
        let bodyStr = body.isEmpty ? "闹钟" : title
        let content = UNMutableNotificationContent()
        
        if #available(iOS 15.0, *) {
            content.interruptionLevel = .timeSensitive
        }
        content.title = titleStr;
        content.subtitle = subTitle;
        content.body = bodyStr;
        content.sound = UNNotificationSound.default

        return content
    }
}

// MARK: 创建通知触发器
extension NotificationManager {
    /// 在特定的地点,发送本地消息推送
    static func triggerWithLocation() {
        // 需要在 Info.plist 设置位置信息
//        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
    }
    
    
    /// 经过一段时间后,发送本地消息推送
    /// - Parameters:
    ///   - timeInterval: 一段时间
    ///   - repeats: 是否重复
    /// - Returns: 本地通知触发器
    static func triggerWithTimeInterval(timeInterval: TimeInterval, repeats: Bool) -> UNNotificationTrigger {
        return UNTimeIntervalNotificationTrigger.init(timeInterval: timeInterval, repeats: repeats)
    }
    
    
    /// 在特定的时间,发送本地消息推送
    /// - Parameters:
    ///   - components: 时间
    ///   - repeats: 是否重复
    /// - Returns: 本地通知触发器
    static func triggerWithDateComponents(components: DateComponents, repeats: Bool) -> UNNotificationTrigger {
        return UNCalendarNotificationTrigger.init(dateMatching: components, repeats: repeats)
    }
}

// MARK: 创建通知的铃声
extension NotificationManager {
    
    /// 根据文件名,创建铃声
    /// - Parameter name: 铃声名称, .wav, . caf 等文件格式
    /// - Returns: 通知铃声对象
    static func soundWithName(_ name: String) -> UNNotificationSound{
        return UNNotificationSound.init(named: UNNotificationSoundName.init(rawValue: name))
    }
}
