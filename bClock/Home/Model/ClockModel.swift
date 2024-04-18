//
//  AlarmClockModel.swift
//  bClock
//
//  Created by bobo on 2024/4/12.
//

import Foundation

let defaultMusic = "lightM_01.caf"

class ClockModel: Codable {
    
    /// 时间
    var date: Date? {
        didSet {
            guard let d = date else {return}
            
            // 处理时间数据,赋值 timeText, timeClock
            let format = DateFormatter()
            format.dateFormat = "ah:mm"
            format.amSymbol = "AM"
            format.pmSymbol = "PM"
            let dateString = format.string(from: d)
            if dateString.contains("AM") || dateString.contains("PM") {
                timeText = dateString.subString(to: 2)
                timeClock = dateString.subString(from: 2)
            } else {
                timeClock = dateString
            }
        }
    }
    
    /// am / pm
    var timeText: String?
    
    /// 时间
    var timeClock: String?
    
    /// 标签
    var tagStr: String?
    
    /// 铃声
    var music: String?
    
    /// 星期列表
    var weekList: [Int]? {
        didSet {
            guard let list = weekList, !list.isEmpty  else {
                weekString = "永不"
                isRepeat = false
                return
            }
            
            isRepeat = true
            
            if list.count == 7 {
                weekString = "每天"
                return
            }
            
            if list.count == 2, list.contains(5), list.contains(6) {
                weekString = "周末"
                return
            }
            
            if list.count == 5, list.contains(0), list.contains(1), list.contains(2), list.contains(3), list.contains(4) {
                weekString = "工作日"
                return
            }
            
            var str = ""
            for e in list {
                var week = ""
                switch e {
                case 0:
                    week = "周一"
                case 1:
                    week = "周二"
                case 2:
                    week = "周三"
                case 3:
                    week = "周四"
                case 4:
                    week = "周五"
                case 5:
                    week = "周六"
                case 6:
                    week = "周日"
                default:
                    week = ""
                }
                if !week.isEmpty {
                    if str.isEmpty {
                        str = week
                    } else {
                        str.append("," + week)
                    }
                }
            }
            weekString = str
        }
    }
    
    /// 星期字符串
    var weekString: String?
    
    /// 标识符
    var identifier: String?
    
    /// 标识符列表
    var identifiers: [String]?
    
    /// 是否开启
    var isOn: Bool?
    
    /// 是否延时
    var isLater: Bool?
    
    /// 是否重复
    var isRepeat: Bool?
    
    /// 添加闹钟
    func addUserNotification() {
        
        guard let list = weekList, !list.isEmpty else {
            let sound = NotificationManager.soundWithName(music ?? defaultMusic)
            let content = NotificationManager.contentWith(title: "时钟", subTitle: "", body: "", sound: sound)
            let components = NotificationManager.componentsWithDate(date ?? Date())
            NotificationManager.addNotificationWithContent(content: content, components: components, identifier: identifier ?? "", isRepeat: isRepeat ?? false) { error in
                if error != nil {
                    debugPrint("创建失败")
                } else {
                    debugPrint("创建成功")
                }
            }
            return
        }
        
        if list.count == 7 { // 每天
            let sound = NotificationManager.soundWithName(music ?? defaultMusic)
            let content = NotificationManager.contentWith(title: "时钟", subTitle: "", body: "", sound: sound)
            let components = NotificationManager.componentsEveryDayWithDate(date ?? Date())
            NotificationManager.addNotificationWithContent(content: content, components: components, identifier: identifier ?? "", isRepeat: isRepeat ?? false) { error in
                if error != nil {
                    debugPrint("创建失败")
                } else {
                    debugPrint("创建成功")
                }
            }
        } else { // 一周中的某天需要闹钟
            for (idx, weekDay) in list.enumerated() {
                let sound = NotificationManager.soundWithName(music ?? defaultMusic)
                let content = NotificationManager.contentWith(title: "时钟", subTitle: "", body: "", sound: sound)
                NotificationManager.addNotificationWithContent(content: content, weekDay: weekDay, date: date ?? Date(), identifier: identifiers?[idx] ?? "", isRepeat: isRepeat ?? false) { error in
                    if error != nil {
                        debugPrint("创建失败")
                    } else {
                        debugPrint("创建成功")
                    }
                }
            }
        }
    }
    
    /// 移除闹钟
    func removeUserNotification() {
        if let id = identifier, !id.isEmpty {
            NotificationManager.shared.removeNotificationWithIdentifier(id)
        }
        
        if let ids = identifiers, !ids.isEmpty {
            NotificationManager.shared.removeNotificationWithIdentifiers(ids)
        }
    }
    
    
    /// 设置多个通知的标识符列表
    func setupIdentifierList() {
        var strList = [String]()
        guard let list = weekList, !list.isEmpty else {
            identifiers = strList
            
            let format = DateFormatter()
            format.dateFormat = formateString
            let d = date ?? Date()
            let dateString = format.string(from: d)
            
            identifier = (isLater ?? false) ? "isLater" + dateString : dateString
            
            return
        }
        
        let format = DateFormatter()
        format.dateFormat = formateString
        let dateString = format.string(from: date ?? Date())
        
        for e in list {
            var week = ""
            switch e {
            case 0:
                week = "周一"
            case 1:
                week = "周二"
            case 2:
                week = "周三"
            case 3:
                week = "周四"
            case 4:
                week = "周五"
            case 5:
                week = "周六"
            case 6:
                week = "周日"
            default:
                week = ""
            }
            if !week.isEmpty {
                let id = dateString + week
                strList.append(id)
            }
        }
        
        identifiers = strList
    }
    
    /// 设置通知标识符
    func setupIdentifier() {
        if let id = identifier, id.isEmpty {
            let format = DateFormatter()
            format.dateFormat = formateString
            let d = date ?? Date()
            let dateString = format.string(from: d)
            
            identifier = (isLater ?? false) ? "isLater" + dateString : dateString
        }
    }
    
}

class AlarmModel: Codable {
    
    /// 时间
    var date: Date
    
    /// am / pm
    var timeText: String
    
    /// 时间
    var timeClock: String
    
    /// 标签
    var tagStr: String
    
    /// 铃声
    var music: String
    
    /// 周几
    var weekList: [Int]
    
    /// 标识符
    var identifier: String
    
    /// 标识符列表
    var identifiers: [String]
    
    /// 是否开启
    var isOn: Bool
    
    /// 是否延时
    var isLater: Bool
    
    /// 是否重复
    var isRepeat: Bool
    
    init(date: Date, timeText: String, timeClock: String, tagStr: String, music: String, weekList: [Int], identifier: String, identifiers: [String], isOn: Bool, isLater: Bool, isRepeat: Bool) {
        self.date = date
        self.timeText = timeText
        self.timeClock = timeClock
        self.tagStr = tagStr
        self.music = music
        self.weekList = weekList
        self.identifier = identifier
        self.identifiers = identifiers
        self.isOn = isOn
        self.isLater = isLater
        self.isRepeat = isRepeat
    }
}
