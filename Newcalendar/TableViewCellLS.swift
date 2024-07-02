//
//  TableViewCellLS.swift
//  Newcalendar
//
//  Created by yujin on 2019/12/19.
//  Copyright © 2019 yujinyano. All rights reserved.
//

import UIKit

class TableViewCellLS: UITableViewCell {

    @IBOutlet weak var L1: UILabel!
  
    
    @IBOutlet weak var S1: UILabel!
    @IBOutlet weak var S2: UILabel!
    @IBOutlet weak var S3: UILabel!
    @IBOutlet weak var S4: UILabel!
    @IBOutlet weak var S5: UILabel!
    @IBOutlet weak var S6: UILabel!
    @IBOutlet weak var S7: UILabel!
    
    
    @IBOutlet weak var V1: UIView!
    @IBOutlet weak var V2: UIView!
    @IBOutlet weak var V3: UIView!
    @IBOutlet weak var V4: UIView!
    @IBOutlet weak var V5: UIView!
    @IBOutlet weak var V6: UIView!
    @IBOutlet weak var V7: UIView!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}

class UIMarginLabel: UILabel {
    
    var topInset:       CGFloat = 0
    var rightInset:     CGFloat = 0
    var bottomInset:    CGFloat = 0
    var leftInset:      CGFloat = 0
    
    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: self.topInset, left: self.leftInset, bottom: self.bottomInset, right: self.rightInset)
        self.setNeedsLayout()
        return super.drawText(in: rect.inset(by: insets))
    }
}
