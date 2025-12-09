//
//  BusinessViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/02/2025.
//

import UIKit

class BusinessViewController: UIViewController {
    @IBOutlet var navigationBar: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
    }
    
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        let settingsVC = ChooseCategoriesViewController(nibName: "ChooseCategoriesViewController", bundle: nil)
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    
    
}
