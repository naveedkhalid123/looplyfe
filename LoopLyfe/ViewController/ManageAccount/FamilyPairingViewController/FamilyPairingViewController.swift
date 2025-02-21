//
//  FamilyPairingViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/02/2025.
//

import UIKit

class FamilyPairingViewController: UIViewController {
    
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var teenView: UIView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        
        parentView.dropShadow(color: .black)
        parentView.layer.cornerRadius = 10
        
        teenView.dropShadow(color: .black)
        teenView.layer.cornerRadius = 10
        
    }
    
    
    @IBAction func parentViewBtnPressed(_ sender: UIButton) {
        print("parent View Clicked")
        
    }
    
    @IBAction func teanViewBtnPressed(_ sender: UIButton) {
        print("tean View Clicked")
    }
    
}
