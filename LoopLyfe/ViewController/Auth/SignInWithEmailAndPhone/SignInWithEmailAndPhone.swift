//
//  SignInWithEmailAndPhone.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 16/02/2025.
//

import UIKit

class SignInWithEmailAndPhone: UIViewController, UITextViewDelegate , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var signInLbl = ["Phone","Email"]
 
    @IBOutlet weak var signInCollectionView: UICollectionView!
    @IBOutlet weak var learnTextView: UITextView!
    
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var emailTextView: UITextView!
    
    
    
    @IBOutlet weak var phoneNumberView: UIView!
    
    @IBOutlet weak var emailView: UIView!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
        configureEmailTextView()
        
        // Add corner radius and background color
        emailTxtField.layer.cornerRadius = 8
        emailTxtField.backgroundColor = UIColor(named: "lightGrey")

        // Add padding using leftView
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTxtField.frame.height))
        emailTxtField.leftView = paddingView
        emailTxtField.leftViewMode = .always


        
        signInCollectionView.delegate = self
        signInCollectionView.dataSource = self
        signInCollectionView.register(UINib(nibName: "SignInCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SignInCollectionViewCell")
    }
    
    func configureTextView() {
        let message = """
        Your phone number will be used to improve your LoopLyfe experience, including connecting you with people you may know, personalizing your ads experience, and more. If you sign up with SMS, SMS fees may apply. Learn more
        """
        
        let links: [String: String] = [
            "Learn more": "https://www.google.com"
        ]
        
        let attributedString = NSMutableAttributedString(string: message, attributes: [
            .foregroundColor: UIColor(named: "darkTxtGrey") ?? UIColor.gray,
            .font: UIFont.systemFont(ofSize: 14)
        ])
        
        for (word, url) in links {
            if let linkRange = message.range(of: word) {
                let nsRange = NSRange(linkRange, in: message)
                attributedString.addAttribute(.link, value: url, range: nsRange)
            }
        }
        
        learnTextView.attributedText = attributedString
        learnTextView.textAlignment = .left
        learnTextView.isEditable = false   // Prevents editing but allows interaction
        learnTextView.isSelectable = true  // Must be true to make links clickable
        learnTextView.isUserInteractionEnabled = true
        learnTextView.dataDetectorTypes = .link // Auto-detects links
        learnTextView.delegate = self
        
        // Ensure links appear black and underlined
        learnTextView.linkTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14, weight: .bold),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }

    
    func configureEmailTextView() {
        let message = """
        Your phone number will be used to improve your LoopLyfe experience, including connecting you with people you may know, personalizing your ads experience, and more. If you sign up with SMS, SMS fees may apply. Learn more
        """
        
        let links: [String: String] = [
            "Learn more": "https://www.google.com"
        ]
        
        let attributedString = NSMutableAttributedString(string: message, attributes: [
            .foregroundColor: UIColor(named: "darkTxtGrey") ?? UIColor.gray,
            .font: UIFont.systemFont(ofSize: 14)
        ])
        
        for (word, url) in links {
            if let linkRange = message.range(of: word) {
                let nsRange = NSRange(linkRange, in: message)
                attributedString.addAttribute(.link, value: url, range: nsRange)
            }
        }
        
        emailTextView.attributedText = attributedString
        emailTextView.textAlignment = .left
        emailTextView.isEditable = false   // Prevents editing but allows interaction
        emailTextView.isSelectable = true  // Must be true to make links clickable
        emailTextView.isUserInteractionEnabled = true
        emailTextView.dataDetectorTypes = .link // Auto-detects links
        emailTextView.delegate = self
        
        // Ensure links appear black and underlined
        emailTextView.linkTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14, weight: .bold),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return signInLbl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignInCollectionViewCell", for: indexPath) as! SignInCollectionViewCell
        cell.signInLbl.text = signInLbl[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: 16)
    }

}
