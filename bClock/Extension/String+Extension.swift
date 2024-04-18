//
//  String+Extension.swift
//  bClock
//
//  Created by bobo on 2024/3/11.
//

import UIKit

extension String {
    func subString(to index: Int) -> String {
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }
    
    func subString(from index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)...])
    }
    
    //截取字符串
    func subString(start:Int, length:Int = -1)->String {
        let end = start + length
        if end < start {
            return ""
        }
        return self[start..<end]
    }
    
    /// String使用下标截取字符串
    /// 例: "示例字符串"[0..<2] 结果是 "示例"
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    
}
