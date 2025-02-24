//
//  ToolsTableViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 24/02/2025.
//

import UIKit

class ToolsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var toolsImage: UIImageView!
    @IBOutlet weak var toolsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
