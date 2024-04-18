//
//  BOAddAlarmVC.swift
//  bClock
//
//  Created by bobo on 2024/3/11.
//

import UIKit
 
/**
 创建 闹钟页
 */

// 对外的常用属性
class BOAddAlarmVC: BOBaseViewController {
    
    var clockModel: ClockModel?
    
    var clockViewModel: ClockViewModel?
    
    var dismissBlcok: (() -> ())?
    
    private let titles = ["铃声", "重复", "贪睡", "关闭闹钟的方法", "备注"]
    
    private
    lazy var tableView: UITableView = {
        let t = UITableView.init()
        
        t.delegate = self
        t.dataSource = self
        t.separatorStyle = .none
        t.tableFooterView = UIView()
        t.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        t.rowHeight = 44.0
        t.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        t.register(UINib.init(nibName: BOSelectableCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: BOSelectableCell.reuseIdentifier)
        t.register(UINib.init(nibName: BOInputCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: BOInputCell.reuseIdentifier)
        
        return t
    }()
    
    /// 时间选择器
    private
    lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        } else {
            
        }
        picker.addTarget(self, action: #selector(handleTime), for: .valueChanged)
        picker.setValue(UIColor.white, forKey: "textColor")
        picker.backgroundColor = UIColor.black.withAlphaComponent(0.8)
//        picker.locale = Locale.init(identifier: "zh_CN")
        return picker
    }()
    
    override func leftBarAction() {
        navigationController?.dismiss(animated: true)
    }
    
    override func rightBarAction() {
        if clockModel?.date == nil {
            clockModel?.date = Date()
        }
        clockModel?.setupIdentifierList()
        clockModel?.isOn = true
        if let model = clockModel {
            clockViewModel?.addClockModel(model)
        }
        
        dismissBlcok?()
        navigationController?.dismiss(animated: true)
    }
}

// MARK: - 系统方法
extension BOAddAlarmVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        
        if clockModel == nil {
            clockModel = ClockModel()
        } else {
            timePicker.date = clockModel?.date ?? Date()
            tableView.reloadData()
        }
    }
}

// MARK: - 公有方法
extension BOAddAlarmVC {
      
     
}

// MARK: - 私有方法
private
extension BOAddAlarmVC {
    
    // UI
    func createUI() {
        setNavMidLabel(text: "添加闹钟", textColor: .white)
        setNavItemLeftLable(text: "取消", textColor: .orange)
        setNavRightLabel(text: "存储", textColor: .orange)
        
        view.addSubview(timePicker)
        timePicker.frame = .init(x: 0, y: 0, width: kScreenWidth, height: 34*7)
        
        view.addSubview(tableView)
        let maxY = timePicker.frame.maxY
        tableView.frame = .init(x: 0, y: maxY, width: kScreenWidth, height: kScreenHeight - maxY)
         
    }
    
}

// MARK: UITableViewDelegate
extension BOAddAlarmVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == titles.count - 1 { // 备注cell
            let cell = tableView.dequeueReusableCell(withIdentifier: BOInputCell.reuseIdentifier, for: indexPath) as! BOInputCell
            cell.titleLabel.text = titles[indexPath.row]
            cell.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            cell.titleLabel.textColor = .white
            cell.remark.attributedPlaceholder = NSAttributedString.init(string: "请输入备注信息", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.7)])
            cell.remark.text = clockModel?.tagStr ?? ""
            cell.textClosure = { string in
                self.clockModel?.tagStr = string
            }
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BOSelectableCell.reuseIdentifier, for: indexPath) as! BOSelectableCell
        var text = ""
        switch indexPath.row {
        case 0: // 铃声
            text = clockModel?.music ?? defaultMusic
            
        case 1: // 重复
            text = clockModel?.weekString ?? ""
            
        default:
            ()
        }
        
        cell.updateCell(titles[indexPath.row], text)
        cell.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let vc = BOAlarmMusicSelectorVC()
            vc.clockModel = clockModel
            vc.backClosure = { text in
                tableView.reloadData()
            }
            navigationController?.pushViewController(vc, animated: true)
            
        case 1:
            let vc = BOAlarmWeekSelectorVC()
            vc.backClosure = { list in
                self.clockModel?.weekList = list
                tableView.reloadData()
            }
            navigationController?.pushViewController(vc, animated: true)
            
        default:
            ()
        }
    }
}


// MARK: - 网络请求
private
extension BOAddAlarmVC {}

// MARK: - 点击事件
@objc
private
extension BOAddAlarmVC {
    func handleTime() {
        let selectDate = timePicker.date
        clockModel?.date = selectDate
    }
}
