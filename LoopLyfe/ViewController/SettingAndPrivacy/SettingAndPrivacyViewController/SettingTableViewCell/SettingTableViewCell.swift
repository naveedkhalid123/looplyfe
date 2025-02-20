//
//  SettingTableViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/02/2025.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var settingImages: UIImageView!
    @IBOutlet weak var settingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
