//
//  BOAlarmWeekSelectorVC.swift
//  bClock
//
//  Created by bobo on 2024/3/22.
//

import UIKit

/**
 闹钟时间,周几选择
 */

// 属性
class BOAlarmWeekSelectorVC: BOBaseViewController {
    
    var clockModel: ClockModel?
    
    var backClosure: (([Int]) -> ())?
    
    /// 日期列表
    private var weekList = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"]
    
    /// 单选的下标
    private var selectArray = [Int]()
    
    // 列表
    private
    lazy var tableView: UITableView = {
        let t = UITableView.init()
        
        t.delegate = self
        t.dataSource = self
        t.backgroundColor = .black.withAlphaComponent(0.8)
        t.tableFooterView = UIView()
        t.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        t.register(UINib.init(nibName: BOSelectableCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: BOSelectableCell.reuseIdentifier)
        
        return t
    }()
    
    override func rightBarAction() {
        backClosure?(selectArray)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - 系统方法
extension BOAlarmWeekSelectorVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavMidLabel(text: "选择铃声", textColor: .white)
        setNavItemLeftLable(text: "取消", textColor: .orange)
        setNavRightLabel(text: "确认", textColor: .orange)
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
}

// MARK: - 公有方法
extension BOAlarmWeekSelectorVC {}

// MARK: - 私有方法
private
extension BOAlarmWeekSelectorVC {}

// MARK: UITableViewDelegate
extension BOAlarmWeekSelectorVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = weekList[indexPath.row]
        cell.tintColor = .orange
        cell.backgroundColor = .clear
        
        if selectArray.contains(indexPath.row) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let e = indexPath.row
        if selectArray.contains(e){
            selectArray = selectArray.filter { $0 != e }
        } else {
            selectArray.append(e)
        } 
        
        tableView.reloadData()
    }
}


// MARK: - 网络请求
private
extension BOAlarmWeekSelectorVC {}

// MARK: - 点击事件
@objc
private
extension BOAlarmWeekSelectorVC {}


 
