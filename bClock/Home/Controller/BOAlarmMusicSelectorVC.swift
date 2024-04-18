//
//  BOAlarmSelectorVC.swift
//  bClock
//
//  Created by bobo on 2024/3/22.
//

import UIKit
import AVFoundation

/**
 创建闹钟时的选择器
 */

// 属性
class BOAlarmMusicSelectorVC: BOBaseViewController {
    
    var clockModel: ClockModel?
    
    var backClosure: ((String) -> ())?
    
    /// 铃声列表
    private var musicList = ["lightM_01.caf",
                             "lightM_02.caf",
                             "lightM_03.caf",
                             "lightM_04.caf",
                             "hotM_01.caf",
                             "hotM_02.caf"]
    
    /// 日期列表
    private var weekList = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"]
    
    /// 单选的下标
    private var radioIndex = 0
    
    /// 播放器
    private
    lazy var player: AVPlayer = {
        let p = AVPlayer()
        p.volume = 1.0;
        return p
    }()
    
    // 列表
    private
    lazy var tableView: UITableView = {
        let t = UITableView.init()
        
        t.delegate = self
        t.dataSource = self
        t.backgroundColor = .black.withAlphaComponent(0.8)
//        t.separatorStyle = .none
        t.tableFooterView = UIView()
        t.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        t.register(UINib.init(nibName: BOSelectableCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: BOSelectableCell.reuseIdentifier)
        
        return t
    }()
    
}

// MARK: - 系统方法
extension BOAlarmMusicSelectorVC {
    override func viewDidLoad() {
        super.viewDidLoad()
         
        setNavMidLabel(text: "选择铃声", textColor: .white)
        setNavItemLeftLable(text: "取消", textColor: .orange)
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        player.pause()
        
        backClosure?(clockModel?.music ?? "")
    }
}

// MARK: - 公有方法
extension BOAlarmMusicSelectorVC {}

// MARK: - 私有方法
private
extension BOAlarmMusicSelectorVC {
    
    func playWithIndex(_ index: Int) {
        if let url = Bundle.main.url(forAuxiliaryExecutable: musicList[index]) {
            let playerItem = AVPlayerItem.init(url: url)
            
            player.replaceCurrentItem(with: playerItem)
            
            player.play()
            
            //震动
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
    }

}

// MARK: UITableViewDelegate
extension BOAlarmMusicSelectorVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = musicList[indexPath.row]
        cell.tintColor = .orange
        cell.backgroundColor = .clear
        
        if (indexPath.row == radioIndex) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        radioIndex = indexPath.row
        tableView.reloadData()
        
        // 播放音乐
        playWithIndex(indexPath.row)
        // 缓存选择
        clockModel?.music = musicList[indexPath.row]
//        BOUserDefaultsConfig.musicName = musicList[indexPath.row]
    }
}


// MARK: - 网络请求
private
extension BOAlarmMusicSelectorVC {
    
}

// MARK: - 点击事件
@objc
private
extension BOAlarmMusicSelectorVC {
    
}
