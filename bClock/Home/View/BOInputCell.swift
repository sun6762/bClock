//
//  BOInputCell.swift
//  bClock
//
//  Created by bobo on 2024/3/11.
//

import UIKit

class BOInputCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var remark: UITextField!
    
    var textClosure: ((String)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        remark.addTarget(self, action: #selector(remarkValueChanged), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @objc
    private
    func remarkValueChanged(tf: UITextField) {
        textClosure?(tf.text ?? "")
    }
}
