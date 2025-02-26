//
//  SafetyTblViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 25/02/2025.
//

import UIKit

class SafetyTblViewCell: UITableViewCell {
    @IBOutlet var safetyImage: UIImageView!
    @IBOutlet var safetyLbl: UILabel!
    @IBOutlet var safetyDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
