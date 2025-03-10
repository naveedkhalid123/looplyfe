//
//  InboxTblViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 10/03/2025.
//

import UIKit

class InboxTblViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var InboxHeadLbl: UILabel!
    @IBOutlet weak var InboxSubHeadLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = 21
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
