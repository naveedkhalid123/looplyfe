//
//  LinkedAccTblViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 21/02/2025.
//

import UIKit

class LinkedAccTblViewCell: UITableViewCell {
    
    
    @IBOutlet weak var linkedAccImage: UIImageView!
    @IBOutlet weak var accountHeadLbl: UILabel!
    @IBOutlet weak var accountSubHeadLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
