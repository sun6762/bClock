//
//  BOFont.swift
//  bClock
//
//  Created by bobo on 2024/3/11.
//

import UIKit

// MARK: - 字体Font -

/// 生成字体
/// - Parameters:
///   - fontName: 字体名称
///   - size: 字号
/// - Returns: 字体
func kFont(fontName: String, size: CGFloat) -> UIFont {
    return UIFont.init(name: fontName, size: size)!
}

/// 普通(系统)字体
/// - Parameter x: 字号
/// - Returns: 字体
func kRegularFont(_ x: CGFloat?) -> UIFont{
    return UIFont.init(name: "PingFangSC-Regular", size: x ?? 10) ?? UIFont.systemFont(ofSize: 10)
}

/// 细字体
/// - Parameter x: 字号
/// - Returns: 字体
func kLightFont(_ x: CGFloat?) -> UIFont{
    return UIFont.init(name: "PingFangSC-Light", size: x ?? 10) ?? UIFont.systemFont(ofSize: 10)
}

/// 中号字体
/// - Parameter x: 字号
/// - Returns: 字体
func kMediumFont(_ x: CGFloat?) -> UIFont{
    return UIFont.init(name: "PingFangSC-Medium", size: x ?? 10) ?? UIFont.systemFont(ofSize: 10)
}

/// 半粗字体
/// - Parameter x: 字号
/// - Returns: 字体
func kSemiboldFont(_ x: CGFloat?) -> UIFont{
    return UIFont.init(name: "PingFangSC-Semibold", size: x ?? 10) ?? UIFont.systemFont(ofSize: 10)
}

/// 斜体字体
/// - Parameter x: 字号
/// - Returns: 字体
func kItalicFont(_ x: CGFloat?) -> UIFont{
    return UIFont.italicSystemFont(ofSize: x ?? 10)
}

/// 粗体字体
/// - Parameter x: 字号
/// - Returns: 字体
func kBoldFont(_ x: CGFloat?) -> UIFont{
    
    return UIFont.boldSystemFont(ofSize: x ?? 10)
}

/// 数字字体
func kNumberFont(_ x: CGFloat?) -> UIFont{
    return UIFont.init(name: "SFProDisplay-Regular", size: x ?? 10) ?? UIFont.systemFont(ofSize: 10)
}

func kNumberMediumFont(_ x: CGFloat?) -> UIFont{
    return UIFont.init(name: "SFProDisplay-Medium", size: x ?? 10) ?? UIFont.systemFont(ofSize: 10)
}
