//
//  CreateUserNameViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 15/02/2025.
//

import UIKit

class CreateUserNameViewController: UIViewController {
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear

    }

}
