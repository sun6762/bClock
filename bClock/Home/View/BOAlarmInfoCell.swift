//
//  BOAlarmInfoCell.swift
//  bClock
//
//  Created by bobo on 2024/4/15.
//

import UIKit

class BOAlarmInfoCell: UITableViewCell {

    @IBOutlet weak var timeText: UILabel!
    
    @IBOutlet weak var timeClock: UILabel!
    
    @IBOutlet weak var timeTag: UILabel!
    
    @IBOutlet weak var timeSwitch: UISwitch!
    
    var switchClosure: ((Bool) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        timeSwitch.borderColor = UIColor.init("#aaaaaa")
        timeSwitch.borderWidth = 1.0
        timeSwitch.cornerRadius = 15.5
    }
    
    
    @IBAction func tapSwitch(_ sender: UISwitch) {
        switchClosure?(sender.isOn)
    }
    
    
    func setupCell(with model: ClockModel) {
        timeText.text = model.timeText
        timeClock.text = model.timeClock
        
        timeTag.text = (model.tagStr ?? "闹钟") + "\t" + (model.weekString ?? "")
        timeSwitch.isOn = model.isOn ?? false
    }
}
