//
//  MainCollectionViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 25/03/2025.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var videosImageView: UIImageView!
    @IBOutlet weak var lblHashtags: UILabel!
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblLikesCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
