//
//  BOMineVC.swift
//  bClock
//
//  Created by bobo on 2024/3/11.
//

import UIKit

/**
     个人中心
 */

// 对外的常用属性
class BOMineVC: UIViewController {
    
}

// MARK: - 系统方法
extension BOMineVC {
    override func viewDidLoad() {
        super.viewDidLoad()
         
        
    }
}
    
// MARK: - 公有方法
extension BOMineVC {}

// MARK: - 私有方法
private
extension BOMineVC {}

// MARK: UITableViewDelegate
extension BOMineVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


// MARK: - 网络请求
private
extension BOMineVC {}

// MARK: - 点击事件
@objc
private
extension BOMineVC {}






 

