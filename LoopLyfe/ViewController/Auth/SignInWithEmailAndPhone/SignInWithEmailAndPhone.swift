//
//  SignInWithEmailAndPhone.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 16/02/2025.
//

import UIKit

class SignInWithEmailAndPhone: UIViewController, UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var signInLbl = [["isSelected":"true","lbl":"Phone"],["isSelected": "false","lbl":"Email"]]
    
    var isSignIn = false
    
    @IBOutlet var navigationBar: UINavigationBar!
    
    @IBOutlet var signInCollectionView: UICollectionView!
    @IBOutlet var learnTextView: UITextView!
    
    @IBOutlet var emailTxtField: UITextField!
    @IBOutlet var emailTextView: UITextView!
    
    @IBOutlet var phoneNumberView: UIView!
    @IBOutlet var emailView: UIView!
    
    
    @IBOutlet weak var passwordTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isSignIn {
            navigationBar.topItem?.title = "Sign In"
            self.emailTextView.isHidden = true
            self.learnTextView.isHidden = true
            
        }else {
            navigationBar.topItem?.title = "Sign Up"
            self.emailTextView.isHidden = false
            self.learnTextView.isHidden = false
        }
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        
        configureTextView()
        configureEmailTextView()
        
        emailTxtField.layer.cornerRadius = 8
        emailTxtField.backgroundColor = UIColor(named: "lightGrey")
        
        

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTxtField.frame.height))
        emailTxtField.leftView = paddingView
        emailTxtField.leftViewMode = .always
        
        passwordTxtField.layer.cornerRadius = 8
        passwordTxtField.backgroundColor = UIColor(named: "lightGrey")
        
        

        let passwordPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTxtField.frame.height))
        passwordTxtField.leftView = passwordPaddingView
        passwordTxtField.leftViewMode = .always
        
        
        
        
        phoneNumberView.isHidden = false
        emailView.isHidden = true
        
        signInCollectionView.delegate = self
        signInCollectionView.dataSource = self
        signInCollectionView.register(UINib(nibName: "SignInCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SignInCollectionViewCell")
    }
    
    func configureTextView() {
        let message = """
        Your phone number will be used to improve your LoopLyfe experience, including connecting you with people you may know, personalizing your ads experience, and more. If you sign up with SMS, SMS fees may apply. Learn more
        """
            
        let links = [
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
        learnTextView.isEditable = false
        learnTextView.isSelectable = true
        learnTextView.isUserInteractionEnabled = true
        learnTextView.dataDetectorTypes = .link
        learnTextView.delegate = self
            
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
            
        let links = [
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
        emailTextView.isEditable = false
        emailTextView.isSelectable = true
        emailTextView.isUserInteractionEnabled = true
        emailTextView.dataDetectorTypes = .link
        emailTextView.delegate = self
            
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
        cell.signInLbl.text = signInLbl[indexPath.row]["lbl"]
        
        if signInLbl[indexPath.row]["isSelected"] == "true" {
            cell.labelView.isHidden = false
        }else {
            cell.labelView.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<signInLbl.count {
            signInLbl[i]["isSelected"] = "false"
        }

        signInLbl[indexPath.row]["isSelected"] = "true"
        

        if indexPath.item == 0 {
            phoneNumberView.isHidden = false
            emailView.isHidden = true
        } else if indexPath.item == 1 {
            phoneNumberView.isHidden = true
            emailView.isHidden = false
        }
        collectionView.reloadData()
    }
    
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func selectPhoneNumberBtnPressed(_ sender: UIButton) {
        print("Select Country Code")
    }
    
}
