//
//  CommentsTblViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 25/02/2025.
//

import UIKit

class CommentsTblViewCell: UITableViewCell {
    
    @IBOutlet weak var commentsHeadLbl: UILabel!
    @IBOutlet weak var commentsDesc: UILabel!
    @IBOutlet weak var commentsSelectedImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
