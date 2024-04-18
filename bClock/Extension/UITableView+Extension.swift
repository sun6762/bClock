//
//  UITableView+Extension.swift
//  bClock
//
//  Created by bobo on 2024/3/11.
//

import UIKit

protocol BOReusableView: AnyObject {}

//复用标识符协议
extension BOReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return "\(self)"
    }
}

//cell 扩展
extension UITableViewCell: BOReusableView { }
extension UICollectionViewCell: BOReusableView { }
