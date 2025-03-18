//
//  FollowerTblViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 17/03/2025.
//

import UIKit

class FollowerTblViewCell: UITableViewCell {
    @IBOutlet weak var followerImage: UIImageView!
    @IBOutlet weak var lblFollower: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnFollowBack: UIButton!
    @IBOutlet weak var btnDismiss: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        followerImage.layer.cornerRadius = 20
        btnFollowBack.layer.cornerRadius = 16

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
