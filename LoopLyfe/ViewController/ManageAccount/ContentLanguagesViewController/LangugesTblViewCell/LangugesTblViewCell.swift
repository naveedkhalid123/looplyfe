//
//  LangugesTblViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 21/02/2025.
//

import UIKit

class LangugesTblViewCell: UITableViewCell {
    
    @IBOutlet weak var selectimage: UIImageView!
    
    @IBOutlet weak var langugesLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
