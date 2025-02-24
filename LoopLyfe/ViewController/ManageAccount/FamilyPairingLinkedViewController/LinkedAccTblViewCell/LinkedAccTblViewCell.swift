//
//  LinkedAccTblViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 21/02/2025.
//

import UIKit

class LinkedAccTblViewCell: UITableViewCell {
    @IBOutlet var linkedAccImage: UIImageView!
    @IBOutlet var accountHeadLbl: UILabel!
    @IBOutlet var accountSubHeadLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
