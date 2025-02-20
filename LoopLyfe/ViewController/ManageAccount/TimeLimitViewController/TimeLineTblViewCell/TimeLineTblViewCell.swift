//
//  TimeLineTblViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/02/2025.
//

import UIKit

class TimeLineTblViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var timeCircleImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
