//
//  LinkedAccountViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/02/2025.
//

import UIKit

class LinkedAccountViewController: UIViewController, UITextViewDelegate  {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var QRScanView: UIView!
    @IBOutlet weak var QRtextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .white
        
        extendedLayoutIncludesOpaqueBars = true

//        edgesForExtendedLayout = [.top]
        
        QRScanView.dropShadow(color: .black)
        QRScanView.layer.cornerRadius = 10
        
        configureTextView()
    }
    
    func configureTextView() {
        let message = """
        Follow these steps on your teen’s account:
        1: Log into LoopLyfe
        2: Go to Settings and privacy > Family Pairing and select Teen.
        3: Scan the QR code to link accounts.
        """
        
        let links: [String: String] = [
            "Settings and privacy >": "app-settings-url",
            "Family Pairing": "app-family-pairing-url",
            "Teen": "app-teen-selection-url"
        ]
        
        let attributedString = NSMutableAttributedString(string: message, attributes: [
            .foregroundColor: UIColor(named: "subHeadGrey") ?? UIColor.gray,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ])
        
        for (word, url) in links {
            if let linkRange = message.range(of: word) {
                let nsRange = NSRange(linkRange, in: message)
                attributedString.addAttributes([
                    .link: url,
                    .font: UIFont.systemFont(ofSize: 16, weight: .bold),
                    .foregroundColor: UIColor(named: "darkTxtGrey") ?? UIColor.gray
                ], range: nsRange)
            }
        }
        
        QRtextView.attributedText = attributedString
        QRtextView.textAlignment = .left
        QRtextView.isEditable = false
        QRtextView.isSelectable = true
        QRtextView.isUserInteractionEnabled = true
        QRtextView.delegate = self
        
        // Ensure links appear correctly
        QRtextView.linkTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
    }
}

// MARK: - UITextViewDelegate to Handle Link Clicks
extension LinkedAccountViewController {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}
