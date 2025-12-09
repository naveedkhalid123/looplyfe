//
//  PromotionsViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 24/02/2025.
//

import UIKit

class PromotionsViewController: UIViewController {
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var lastDaysButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func lastDaysBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func coinsSpentViewPressed(_ sender: UIButton) {
        print("Coins spent view pressed")
    }
    
    @IBAction func videoSpentVuewPressed(_ sender: UIButton) {
        print("Videos spent view pressed")
    }
    
    @IBAction func linkClickedViewPressed(_ sender: UIButton) {
        print("Links spent view pressed")
    }
    
    @IBAction func likesViewPressed(_ sender: UIButton) {
        print("Videos spent view pressed")
    }
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
