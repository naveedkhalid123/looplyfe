//
//  WalletTblViewCell.swift
//  LoopLyfe
//
//  Created by iMac on 06/12/2025.
//

import UIKit

class WalletTblViewCell: UITableViewCell {
    
    @IBOutlet weak var lblNumberOfCoins: UILabel!
    @IBOutlet weak var btnPrice: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnPrice.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
