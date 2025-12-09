//
//  UserSuggestionTableCell.swift
//  LoopLyfe
//
//  Created by iMac on 24/10/2025.
//

import UIKit

class UserSuggestionTableCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnFollowing: UIButton!
    @IBOutlet weak var btnDismiss: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnFollowing.layer.cornerRadius = 8
        profileImage.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
