//
//  MessageSettingTblViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/02/2025.
//

import UIKit

class MessageSettingTblViewCell: UITableViewCell {
    
    
    @IBOutlet weak var messageHeadLbl: UILabel!
    @IBOutlet weak var messageSubHeadLbl: UILabel!
    @IBOutlet weak var messageDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
