//
//  HomeTabelViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 18/02/2025.
//

import UIKit

class HomeTabelViewCell: UITableViewCell {
    
    

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postCaptionLbl: UILabel!
    @IBOutlet weak var postHashTagsLbl: UILabel!
    @IBOutlet weak var soundNameLbl: UILabel!
    
    @IBOutlet weak var followProfileBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var commentCountLbl: UILabel!
    @IBOutlet weak var shareLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
