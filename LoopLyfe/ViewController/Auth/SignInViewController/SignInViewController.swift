//
//  SignInViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 16/02/2025.
//

import UIKit

class SignInViewController: UIViewController, UITextViewDelegate {
    @IBOutlet var emailView: UIView!
    @IBOutlet var facebookView: UIView!
    @IBOutlet var appleView: UIView!
    @IBOutlet var googleView: UIView!
    
    @IBOutlet var policyTxtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailView.layer.cornerRadius = 2
        emailView.layer.borderWidth = 0.6
        emailView.layer.borderColor = UIColor(named: "viewLineGrey")?.cgColor
        
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
        
        policyTxtView.attributedText = attributedString
        policyTxtView.textAlignment = .center
        policyTxtView.isEditable = false
        policyTxtView.isSelectable = true
        policyTxtView.isUserInteractionEnabled = true
        policyTxtView.delegate = self
        
        // Ensure links appear black
        policyTxtView.linkTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
    
        policyTxtView.attributedText = attributedString
        policyTxtView.textAlignment = .center
        policyTxtView.isEditable = false
        policyTxtView.isSelectable = true
        policyTxtView.isUserInteractionEnabled = true
        policyTxtView.delegate = self
        
        // Ensure links appear black
        policyTxtView.linkTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
    }
    
    @IBAction func emailBtnPressed(_ sender: UIButton) {
        let vc = SignInWithEmailAndPhone(nibName: "SignInWithEmailAndPhone", bundle: nil)
        vc.isSignIn = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func facebookBtnPresed(_ sender: UIButton) {
        print("phone btn facebook")
    }
    
    @IBAction func appleBtnPressed(_ sender: UIButton) {
        print("phone btn apple")
    }
    
    @IBAction func googleBtnPressed(_ sender: UIButton) {
        print("phone btn google")
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
       
        let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
