//
//  ClockViewModel.swift
//  bClock
//
//  Created by bobo on 2024/4/12.
//

import Foundation
import Cache

let saveClockDataKey = "saveClockDataKey"

class ClockViewModel {
    
    /// 通知时间数据列表
    var clockData = [ClockModel]()
    
    private lazy var storage: Storage<String, [ClockModel]> = {
        let storage = CacheTool.cacheTool(type: [ClockModel].self)
        
        return storage
    }()
    
    /// 缓存数据
    func saveData() {
        try? storage.setObject(clockData, forKey: saveClockDataKey)
    }
    
    /// 读取缓存
    func readData() {
        let entry = try? storage.entry(forKey: saveClockDataKey)
        let datas = entry?.object
        
        if let d = datas, !d.isEmpty {
            clockData = d
        }
        
        NotificationManager.shared.getDeliveredNotificationIdentiferBlock { identifiers in
            for e in identifiers {
                self.reciveNotificationWithIdentifier(e)
            }
        }
    }
    
    /// 添加数据模型
    func addClockModel(_ model: ClockModel) {
        clockData.append(model)
        saveData()
        model.addUserNotification()
    }
    
    /// 替换数据模型
    func replaceModel(index: Int, model: ClockModel) {
        clockData[index].removeUserNotification()
        clockData[index] = model
        saveData()
        model.addUserNotification()
    }
    
    /// 删除模型
    func removeClockModel(_ model: ClockModel) {
        model.removeUserNotification()
        
        var list = [ClockModel]()
        for e in clockData {
            //FIXME:  删除需要修改
            if e.identifier != model.identifier {
                list.append(e)
            }
        }
        clockData = list
        
        saveData()
    }
    
    /// 删除指定模型
    func removeClockAtIndex(index: Int) {
        removeClockModel(clockData[index])
    }
    
    /// 改变开关
    func changeClockWithSwitch(isOpen: Bool, model: ClockModel){
        model.isOn = isOpen
        isOpen ? model.addUserNotification() : model.removeUserNotification()
        saveData()
    }
    
    /// 收到通知后
    func reciveNotificationWithIdentifier(_ identifier: String) {
        for e in clockData {
            if identifier.hasPrefix(e.identifier ?? "") || (e.identifier == identifier && e.weekList?.isEmpty == true) {
                changeClockWithSwitch(isOpen: false, model: e)
            }
        }
    }
    
    
}
