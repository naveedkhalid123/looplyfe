//
//  SignUpViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 14/02/2025.
//

import UIKit

class SignUpViewController: UIViewController, UITextViewDelegate  {
    
    

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var appleView: UIView!
    @IBOutlet weak var googleView: UIView!
    
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
    @IBOutlet weak var privacyTxtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        profileView.layer.cornerRadius = 2
        profileView.layer.borderWidth = 0.6
        profileView.layer.borderColor = UIColor(named: "viewLineGrey")?.cgColor
        
        facebookView.layer.cornerRadius = 2
        facebookView.layer.borderWidth = 0.6
        facebookView.layer.borderColor = UIColor(named: "viewLineGrey")?.cgColor
        
        appleView.layer.cornerRadius = 2
        appleView.layer.borderWidth = 0.6
        appleView.layer.borderColor = UIColor(named: "viewLineGrey")?.cgColor
        
        googleView.layer.cornerRadius = 2
        googleView.layer.borderWidth = 0.6
        googleView.layer.borderColor = UIColor(named: "viewLineGrey")?.cgColor
    
        configureTextView()
    }
    
    func configureTextView() {
        let message = "By tapping “Continue”, you agree to our Terms of Service and acknowledge that you have read our Privacy Policy to learn how we collect, use, and share your data."
        
        let links: [String: String] = [
            "Terms of Service": "https://www.google.com",
            "Privacy Policy": "https://www.apple.com"
        ]
        
        let attributedString = NSMutableAttributedString(string: message, attributes: [
            .foregroundColor: UIColor(named: "darkTxtGrey") ?? UIColor.gray,
            .font: UIFont.systemFont(ofSize: 16)
        ])
        
        for (word, url) in links {
            if let linkRange = message.range(of: word) {
                let nsRange = NSRange(linkRange, in: message)
                attributedString.addAttributes([
                    .link: url
                ], range: nsRange)
            }
        }
        
        privacyTxtView.attributedText = attributedString
        privacyTxtView.textAlignment = .center
        privacyTxtView.isEditable = false
        privacyTxtView.isSelectable = true
        privacyTxtView.isUserInteractionEnabled = true
        privacyTxtView.delegate = self
        
        // Ensure links appear black
        privacyTxtView.linkTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
    

        
        privacyTxtView.attributedText = attributedString
        privacyTxtView.textAlignment = .center
        privacyTxtView.isEditable = false
        privacyTxtView.isSelectable = true
        privacyTxtView.isUserInteractionEnabled = true
        privacyTxtView.delegate = self
        
        // Ensure links appear black
        privacyTxtView.linkTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
    }
    
    
    @IBAction func phoneBtnPressed(_ sender: UIButton) {
        print("phone btn pressed")
    }
    
    @IBAction func facebookBtnPressed(_ sender: UIButton) {
        print("phone btn fb")
    }
    
    @IBAction func appleBtnPressed(_ sender: UIButton) {
        print("phone btn apple")
    }
    
    @IBAction func googleBtnPressed(_ sender: UIButton) {
        print("phone btn google")
    }
    
    
    
    @IBAction func signInBtnPressed(_ sender: UIButton) {
        print("Sign in btn pressed")
    }
    
    
    
}


// MARK: - UITextViewDelegate to Handle Link Clicks
extension SignUpViewController {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}


