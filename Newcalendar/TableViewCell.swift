//
//  TableViewCell.swift
//  Newcalendar
//
//  Created by yujinyano on 2018/07/21.
//  Copyright © 2018年 yujinyano. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label1plus: UILabel!
    
    @IBOutlet weak var playback: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
