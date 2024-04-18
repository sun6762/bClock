//
//  UIColor+Extension.swift
//  bClock
//
//  Created by bobo on 2024/3/11.
//

import UIKit

public
extension UIColor {
//    var MainColor: UIColor {
//        return
//    }
}

/// 十六进制颜色转 UIColor
public extension UIColor {
    
    /// 十六进制颜色转 UIColor
    convenience init(_ hex: String) {
        if let rgbColor = hex.rgbColor  {
            self.init(red: rgbColor.red, green: rgbColor.green, blue: rgbColor.blue, alpha: rgbColor.alpha)
        }else{
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}

// hex 字符串转 颜色色值
private extension String {
    private var pureHexColor: String {
        return trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
    }
    
    struct RGBColor {
        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat
        let alpha: CGFloat
    }
    
    var rgbColor: RGBColor? {
        if pureHexColor.count == 6 {
            return pureHexColor.rgbColorFrom6Hex()
        } else if pureHexColor.count == 8 {
            return pureHexColor.rgbColorFrom8Hex()
        } else {
            return nil
        }
    }
    
    private func rgbColorFrom6Hex() -> RGBColor? {
        guard let rgb = hexToInt32() else { return nil }
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        return RGBColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    private func rgbColorFrom8Hex() -> RGBColor? {
        guard let rgb = hexToInt32() else { return nil }
        let red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
        let green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
        let blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
        let alpha = CGFloat(rgb & 0x000000FF) / 255.0
        return RGBColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    private func hexToInt32() -> UInt32? {
        var rgb: UInt32 = 0
        guard Scanner(string: self).scanHexInt32(&rgb) else { return nil }
        return rgb
    }
}
