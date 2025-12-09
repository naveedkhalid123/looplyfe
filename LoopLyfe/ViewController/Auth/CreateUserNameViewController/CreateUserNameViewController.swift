//
//  CreateUserNameViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 15/02/2025.
//

import UIKit

class CreateUserNameViewController: UIViewController, UITextFieldDelegate {
    
    var social: String = ""
    var email: String = ""
    var dateOfBirth: String = ""
    var password: String = ""
    
    var isFromCreatePassword = false
    
    var usernameViewModel = UsernameViewModel()
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var successUsernameImage: UIButton!
    @IBOutlet weak var warningView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        
        print("Social", social)
        print("email", email)
        print("dateOfBirth", dateOfBirth)
        print("password", password)
        
        tfUsername.delegate = self
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if usernameViewModel.isValidUsername(textField.text ?? "") == true {
            self.successUsernameImage.isHidden = false
        }else {
            self.successUsernameImage.isHidden = true
        }
    }
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signupBtnTapped(_ sender: Any) {
        
        guard var username = tfUsername.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !username.isEmpty else {
            Utility.shared.showToast(message: "Username cannot be empty.")
            return
        }
        
        if username.contains(" ") {
            Utility.shared.showToast(message: "Username cannot contain spaces.")
            return
        }

        if username.count < 3 {
            Utility.shared.showToast(message: "Username must be at least 3 characters long.")
            return
        }
                
        if social == "email" {
            usernameViewModel.checkUsername(username: username) { result in
                switch  result {
                case .success(let status):
                    print("Status", status)
                    self.usernameViewModel.createUser(email: self.email, password: self.password, social: self.social, username: username) { result in
                        switch result {
                        case .success(let status):
                            self.navigationController?.popToRootViewController(animated: true)
                            
                        case .failure(let error):
                            Utility.shared.showToast(message: error.localizedDescription)
                        }
                        
                    }

                case .failure(let error):
                    print("error", error.localizedDescription)
                    self.warningView.isHidden = false
                    
                }
            }
        }else {
            // phone number
            let vc = OTPVerificationViewController(nibName: "OTPVerificationViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }


}
