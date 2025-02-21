//
//  HelpingResourcesTableViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 21/02/2025.
//

import UIKit

class HelpingResourcesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var resourcesImage: UIImageView!
    @IBOutlet weak var resourcesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
