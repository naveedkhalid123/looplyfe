//
//  HashtagsTblViewCell.swift
//  LoopLyfe
//
//  Created by iMac on 10/12/2025.
//

import UIKit

class HashtagsTblViewCell: UITableViewCell {
    
    @IBOutlet weak var hashtagsImage: UIImageView!
    @IBOutlet weak var lblHashtags: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
