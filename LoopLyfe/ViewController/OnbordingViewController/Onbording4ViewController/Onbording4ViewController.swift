//
//  Onbording4ViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 14/02/2025.
//

import UIKit

class Onbording4ViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var termsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
    }
    
    func configureTextView() {
        let message = "By tapping “Agree and continue”, you agree to our Terms of Service and acknowledge that you have read our Privacy Policy to learn how we collect, use, and share your data."
        
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
        
        termsTextView.attributedText = attributedString
        termsTextView.textAlignment = .center
        termsTextView.isEditable = false
        termsTextView.isSelectable = true
        termsTextView.isUserInteractionEnabled = true
        termsTextView.delegate = self
        
        // Ensure links appear black
        termsTextView.linkTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
    }
}

// MARK: - UITextViewDelegate to Handle Link Clicks
extension Onbording4ViewController {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}
