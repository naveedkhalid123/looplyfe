//
//  InterestCollectionViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 14/02/2025.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var interestView: UIView!
    @IBOutlet weak var interestLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        interestView.layer.borderWidth = 1
        interestView.layer.borderColor = UIColor(named: "shdow")?.cgColor
        
        interestView.dropShadow(color: .shdow )
        
    }

}
