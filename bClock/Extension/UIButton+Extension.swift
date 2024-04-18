//
//  UIButton+Extension.swift
//  bClock
//
//  Created by bobo on 2024/3/11.
//

import UIKit

extension UIButton{
    /// 创建一般按钮
    convenience init(titleColor:UIColor?, font:UIFont?, title:String?) {
        self.init(type: UIButton.ButtonType.custom)
        self.setTitle(title, for: UIControl.State.normal)
        self.setTitle(title, for: UIControl.State.highlighted)
        self.setTitleColor(titleColor, for: UIControl.State.normal)
//        self.setTitleColor(titleColor, for: UIControl.State.highlighted)
        self.titleLabel?.font = font
    }
    
    convenience init(title: String?, font: UIFont? = kRegularFont(18)) {
        self.init()
        self.setTitle(title, for: UIControl.State.normal)
//        self.setTitle(title, for: UIControl.State.highlighted)
        self.layer.cornerRadius = 4.0
        self.titleLabel?.font = font
    }
    
    convenience init(imgName:String?, selectedImgName:String? = "", highlightedImgName: String? = "") {
        self.init(type: UIButton.ButtonType.custom)
        self.setImage(UIImage.init(named: imgName ?? ""), for: UIControl.State.normal)
        if let sImgName = selectedImgName, sImgName.isEmpty == false{
            self.setImage(UIImage.init(named: sImgName), for: UIControl.State.selected)
        }
        
        if let hImgName = highlightedImgName, hImgName.isEmpty == false {
            self.setImage(UIImage.init(named:hImgName), for: UIControl.State.highlighted)
        }
    }
    
    func setAllTitleColor(_ color: UIColor?) {
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(color, for: .highlighted)
    }
    
    // 同时设置文字不同点击状态的文字
    func setAllTitle(_ text: String?) {
        self.setTitle(text, for: .normal)
        self.setTitle(text, for: .highlighted)
    }
}

/// Button 中的图片位置枚举
enum eButtonImagePosition {
    case top          //图片在上，文字在下，垂直居中对齐
    case bottom       //图片在下，文字在上，垂直居中对齐
    case left         //图片在左，文字在右，水平居中对齐
    case right        //图片在右，文字在左，水平居中对齐
}

extension UIButton{
    /// - Description 设置Button图片的位置
    /// - Parameters:
    ///   - style: 图片位置
    ///   - spacing: 按钮图片与文字之间的间隔
    func imagePosition(style: eButtonImagePosition, spacing: CGFloat) {
        //得到imageView和titleLabel的宽高
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        
        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0
        
        labelWidth = self.titleLabel?.intrinsicContentSize.width
        labelHeight = self.titleLabel?.intrinsicContentSize.height
        
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .top:
            //上 左 下 右
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-spacing/2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-spacing/2, right: 0)
            break;
            
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
            break;
            
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-spacing/2, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-spacing/2, left: -imageWidth!, bottom: 0, right: 0)
            break;
            
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+spacing/2, bottom: 0, right: -labelWidth-spacing/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-spacing/2, bottom: 0, right: imageWidth!+spacing/2)
            break;
            
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
    }
}
