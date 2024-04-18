//
//  BOAddClockVC.swift
//  bClock
//
//  Created by bobo on 2024/3/11.
//

import UIKit

/**
 添加各种类型的时钟
 */

// 对外的常用属性
class BOAddClockVC: BOBaseViewController {
    
    // 列表
    private
    lazy var tableView: UITableView = {
        let t = UITableView.init()
        t.delegate = self
        t.dataSource = self
        t.separatorStyle = .none
        t.rowHeight = 44.0
        t.register(UINib.init(nibName: BOAddClockCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: BOAddClockCell.reuseIdentifier)
//        t.register(BOAddClockCell.self, forCellReuseIdentifier: BOAddClockCell.reuseIdentifier)
        return t
    }()
    
    
    /// 图片数组
    private let images = [
        Pic.Home.alarm,
        Pic.Home.timer,
        Pic.Home.sleep,
        Pic.Home.countDown
    ]
    
    /// 标题数组
    private let titleArray = ["闹钟", "计时器", "睡眠计时器", "倒计时"]
}

// MARK: - 系统方法
extension BOAddClockVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "添加"
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - 公有方法
extension BOAddClockVC {}

// MARK: - 私有方法
private
extension BOAddClockVC {}

// MARK: UITableViewDelegate
extension BOAddClockVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BOAddClockCell.reuseIdentifier, for: indexPath) as! BOAddClockCell
        cell.titleLabel.text = titleArray[indexPath.row]
        cell.icon.image = UIImage.init(named: images[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BOAddAlarmVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - 网络请求
private
extension BOAddClockVC {}

// MARK: - 点击事件
@objc
private
extension BOAddClockVC {}
 
