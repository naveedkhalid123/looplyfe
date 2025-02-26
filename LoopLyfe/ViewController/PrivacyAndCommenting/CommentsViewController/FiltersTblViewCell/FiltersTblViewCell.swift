//
//  FiltersTblViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 25/02/2025.
//

import UIKit

class FiltersTblViewCell: UITableViewCell {
    
    
    @IBOutlet weak var filterHeadLbl: UILabel!
    @IBOutlet weak var filterDesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
