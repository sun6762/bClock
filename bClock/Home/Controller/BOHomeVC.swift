//
//  BOHomeVC.swift
//  bClock
//
//  Created by bobo on 2024/3/11.
//

import UIKit
import SnapKit

class BOHomeVC: BOBaseViewController {

    let viewModel = ClockViewModel()
    
    // 列表
    private
    lazy var tableView: UITableView = {
        let t = UITableView.init()
        
        t.delegate = self
        t.dataSource = self
        t.backgroundColor = .black.withAlphaComponent(0.8)
//        t.separatorStyle = .none
        t.rowHeight = 80
        t.separatorColor = .white
        t.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        t.register(UINib.init(nibName: BOAlarmInfoCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: BOAlarmInfoCell.reuseIdentifier)
        t.tableFooterView = UIView()
        
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
        
        viewModel.readData()
        tableView.reloadData()
    }
    
    override func rightBarAction() {
        let vc = BOAddAlarmVC()
        vc.clockViewModel = viewModel
        vc.dismissBlcok = {
            self.tableView.reloadData()
        }
        let nav = UINavigationController.init(rootViewController: vc)
        navigationController?.present(nav, animated: true)
    }
    
    override func leftBarAction() {
        
    }
}


private
extension BOHomeVC {
    func createUI () {
        setNavMidLabel(text: "闹钟", textColor: .white)
        setNavItemLeftLable(text: "编辑", textColor: .orange)
        setNavRightLabel(text: "+", textColor: .orange, textFont: kBoldFont(28))
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
}

@objc
private
extension BOHomeVC {
    func tapForAdd() {
        
    }
}

extension BOHomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.clockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BOAlarmInfoCell.reuseIdentifier, for: indexPath) as! BOAlarmInfoCell
        let model = viewModel.clockData[indexPath.row]
        cell.setupCell(with:  model)
        cell.switchClosure = { isOpen in
            self.viewModel.changeClockWithSwitch(isOpen: isOpen, model: model)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.clockData[indexPath.row]
        
        let vc = BOAddAlarmVC()
        vc.clockViewModel = viewModel
        vc.clockModel = model
        vc.dismissBlcok = {
            tableView.reloadData()
        }
        let nav = UINavigationController.init(rootViewController: vc)
        navigationController?.present(nav, animated: true)
        
    }
    
}

