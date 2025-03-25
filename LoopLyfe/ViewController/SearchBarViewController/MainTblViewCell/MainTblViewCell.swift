//
//  MainTblViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 25/03/2025.
//

import UIKit

class MainTblViewCell: UITableViewCell {
    
    @IBOutlet var ImgUsrProfile: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblFollowers: UILabel!
    @IBOutlet var btnFollow: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ImgUsrProfile.layer.cornerRadius = 25
        btnFollow.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func followBtnPressed(_ sender: UIButton) {
        
    }
    
}
