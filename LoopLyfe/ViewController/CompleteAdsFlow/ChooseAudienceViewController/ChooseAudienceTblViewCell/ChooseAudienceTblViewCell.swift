//
//  ChooseAudienceTblViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 24/02/2025.
//

import UIKit

class ChooseAudienceTblViewCell: UITableViewCell {

    @IBOutlet weak var chooseAudienceLbl: UILabel!
    @IBOutlet weak var selectedAudienceIm: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
