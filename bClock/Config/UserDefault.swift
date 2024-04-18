//
//  UserDefault.swift
//  bClock
//
//  Created by bobo on 2024/3/22.
//

import Foundation

// MARK: - UserDefaults -

struct BOUserDefaultsConfig {
    
    /// 用户首次登录是否同意隐私政策
    @BOUserDefaults("musicName", defaultValue: "lightM_01.caf")
    static var musicName: String
    
}



@propertyWrapper
struct BOUserDefaults<T> {
    
    let key: String
    let defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get{
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}
