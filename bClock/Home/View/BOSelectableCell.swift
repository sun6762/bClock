//
//  BOSelectableCell.swift
//  bClock
//
//  Created by bobo on 2024/3/11.
//

import UIKit

class BOSelectableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var subtitleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateCell(_ title: String, _ subtitle: String? = "") {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
}
