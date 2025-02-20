//
//  RepostDoneViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 19/02/2025.
//

import UIKit

class RepostDoneViewController: UIViewController {
    
    

    @IBOutlet weak var repostDoneTxtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        repostDoneTxtField.backgroundColor = UIColor(named: "lightGrey")
        repostDoneTxtField.layer.cornerRadius = 10
     
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: repostDoneTxtField.frame.height))
        repostDoneTxtField.leftView = paddingView
        repostDoneTxtField.leftViewMode = .always

    }


}
