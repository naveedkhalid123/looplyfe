//
//  SoundsTblViewCell.swift
//  LoopLyfe
//
//  Created by iMac on 10/12/2025.
//

import UIKit

class SoundsTblViewCell: UITableViewCell {
    
    @IBOutlet weak var soundImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
