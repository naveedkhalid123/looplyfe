//
//  ProfileCollectionViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 10/03/2025.
//

//import UIKit
//
//class ProfileCollectionViewCell: UICollectionViewCell {
//    
//    
//    @IBOutlet weak var profileImages: UIImageView!
//    
//    @IBOutlet weak var selectedView: UIView!
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//}


import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImages: UIImageView!
    @IBOutlet weak var selectedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedView.isHidden = true
    }
    
    func configureCell(with imageUrl: String, isSelected: Bool) {
        profileImages.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder"))
        
    
    }
}
