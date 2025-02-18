//
//  OTPVerificationViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 15/02/2025.
//

import UIKit
import DPOTPView

class OTPVerificationViewController: UIViewController, DPOTPViewDelegate {

    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var OTPView: DPOTPView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        
        OTPView.dpOTPViewDelegate = self
        OTPView.count = 6
        
        OTPView.borderColorTextField = .lightGray
        OTPView.borderWidthTextField = 1
        OTPView.cornerRadiusTextField = 0
        OTPView.selectedBorderColorTextField = .systemYellow
        OTPView.selectedBorderWidthTextField = 1.5
        OTPView.spacing = 15
        OTPView.tintColorTextField = .red

        OTPView.backGroundColorTextField = .clear
        OTPView.textColorTextField = .black
        OTPView.fontTextField = UIFont.systemFont(ofSize: 22, weight: .medium)
        OTPView.isBottomLineTextField = true
    }


    
    func dpOTPViewAddText(_ text: String, at position: Int) {
        
    }
    
    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        
    }
    
    func dpOTPViewChangePositionAt(_ position: Int) {
        
    }
    
    func dpOTPViewBecomeFirstResponder() {
        
    }
    
    func dpOTPViewResignFirstResponder() {
        
    }
    
}
