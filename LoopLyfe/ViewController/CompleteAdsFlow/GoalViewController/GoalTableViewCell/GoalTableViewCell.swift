//
//  GoalTableViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 24/02/2025.
//

import UIKit

class GoalTableViewCell: UITableViewCell {
    

    @IBOutlet weak var goalImage: UIImageView!
    @IBOutlet weak var goalHead: UILabel!
    @IBOutlet weak var goalSubHead: UILabel!
    @IBOutlet weak var goalSelectedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
