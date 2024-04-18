//
//  BOColor.swift
//  bClock
//
//  Created by bobo on 2024/3/11.
//

import UIKit

// MARK: - 颜色相关 -
struct AppColor{
    static let appPrimaryColor = UIColor.white.withAlphaComponent(0.5)
     
    /// 随机色
    static let RandomColor = UIColor.init(red: CGFloat(arc4random())/256.0, green: CGFloat(arc4random())/256.0, blue: CGFloat(arc4random())/256.0, alpha: 1.0)
    
    /// 00599A
    static let ThemeColor = UIColor.init("#00599A") // 主题色
    
    /// 文字头像颜色
    static let AvatarColor = UIColor.init("#4990E2")
    
    /// 颜色 BBBBBB
    static let SplitLineColor = UIColor.init("#BBBBBB")
    
    /// 004588
    static let MainColor = UIColor.init("#004588") // 标题正文
    
    /// 3E3E3E
    static let WeightBlack = UIColor.init("#3E3E3E") // 全局titlebar文字、主文案文字颜色

    
    /// 0B0E20 0.7 alpha  mask 的颜色
    static let MaskColor = UIColor.init("#0B0E20").withAlphaComponent(0.7)
    
    /// 888888
    static let Gray88Color = UIColor.init("#888888")
    
    /// 标题正文 000000,0.7
    static let MainBlack = UIColor.black.withAlphaComponent(0.7)
    
    /// 副标题   000000,0.4
    static let LightBlack = UIColor.black.withAlphaComponent(0.4)
    
    /// 预填 EFEFF4
    static let PlacedColor = UIColor.init("#EFEFF4")
    
    ///  聊天 F7F7F7
    static let ChatColor = UIColor.init("#F7F7F7")
    
    /// 错误文本 F0494E
    static let ErrorColor = UIColor.init("#F0494E")
    
    /// 文字链接 0053BE
    static let LinkColor = UIColor.init("#0053BE")
    
    /// 848B94 灰色
    static let GrayColor = UIColor.init("#848B94")
    
    /// 8E8E8E 灰色
    static let Gray8EColor = UIColor.init("#8E8E8E")
    
    /// E5E5E5 分割线颜色
    static let LineColor = UIColor.init("#E5E5E5")
    
    /// F6F6F6  灰色
    static let GratF6Color = UIColor("#F6F6F6")
    
    /// DDDDDD 边框颜色
    static let GrayDDColor = UIColor.init("#DDDDDD")
    
    /// D7D7DA 边框颜色
    static let D7Color = UIColor.init("#D7D7DA")
    
    /// F0EFF4 间隔颜色
    static let SpaceColor = UIColor.init("#F0EFF4")
     
    /// F7F8FA  背景灰色
    static let GrayBackGroundColor = UIColor.init("#F7F8FA")
    
    /// F7890C  橙色
    static let OrangeColor = UIColor.init("#F7890C")
    
    /// E7590F
    static let MineOrange = UIColor.init("#E7590F")
    
    /// 0C275F
    static let MineBlue = UIColor.init("#0C275F")
    
    
    /// 1DBD5F  绿色 成功
    static let GreenColor = UIColor.init("#1DBD5F")
    
    /// E86456  红色 失败/拒绝
    static let RedColor = UIColor.init("#E86456")
    
    /// F5A623 黄色
    static let YellowColor = UIColor.init("#F5A623")
    
    /// 角标颜色
    static let BadgeColor = UIColor.init("#FF3B30")
    
    /// 投影 颜色
    static let ShadowColor = UIColor.black.withAlphaComponent(0.16)
    
    /// 淡蓝色
    static let LightBlueColor = UIColor("#EBF5FF")
    
    /// F3F8FB
    static let WhiteBlueColor = UIColor("#F3F8FB") // 登录页的 淡蓝色
     
    /// B3CDE0
    static let LightMainColor = UIColor("#B3CDE0") // 登录页的 未选中的按钮颜色
    
    /// 3F5B76  深蓝色
    static let NavyBlueColor = UIColor("#3F5B76")
    
    /// D7EAFE 选中蓝色
    static let BlueD7Color = UIColor("#D7EAFE")
    
    /// EBF2FA 浅蓝色
    static let BlueEBColor = UIColor("#EBF2FA")
    
    /// E6EEF6 浅蓝色
    static let BlueE6Color = UIColor("#E6EEF6")
    
}

struct OrderColor {
    /// 青色 7290C8
    static let CyanColor = UIColor.init("#7290C8")
    
    /// 黄色 #F1B654
    static let YellowColor = UIColor.init("#F1B654")
    
    /// #3AB034 绿色
    static let GreenColor = UIColor.init("#3AB034")
    
    /// #45AA09 深绿色
    static let DarkGreenColor =  UIColor.init("#45AA09")
    
    /// ##45AA09 绿色
    static let Green1Color = UIColor.init("#45AA09")
    
    /// E44D3C 红色
    static let RedColor = UIColor.init("#E44D3C")
    /// E44D3C 红色
    static let LightRedColor = UIColor.init("#E86455")
    
    /// 灰色
    static let GrayColor = UIColor.black.withAlphaComponent(0.4)
}
