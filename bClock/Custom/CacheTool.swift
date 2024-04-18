//
//  CacheTool.swift
//  bClock
//
//  Created by bobo on 2024/4/12.
//

import Foundation
import Cache

/// 闹钟缓存名称
let CacheName = "AlarmCache"

class CacheTool: NSObject {

    class func cacheTool<T: Codable>(type: T.Type) -> Storage<String, T> {
        let diskConfig = DiskConfig(name: CacheName)
        let memoryConfig = MemoryConfig(expiry: .never, countLimit: 100, totalCostLimit: 100)

        let storage = try? Storage<String, T>(
          diskConfig: diskConfig,
          memoryConfig: memoryConfig,
          transformer: TransformerFactory.forCodable(ofType: T.self) // Storage<String, Item>
        )
        return storage!
    }
    
}
