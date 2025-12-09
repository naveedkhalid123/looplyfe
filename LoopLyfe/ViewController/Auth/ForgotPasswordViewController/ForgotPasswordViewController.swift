//
//  ForgotPasswordViewController.swift
//  LoopLyfe
//
//  Created by iMac on 07/11/2025.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    let resetPasswordViewModel = ForgotPasswordViewModel()
    let validateEmail = SigninEmailPhoneViewModel()
    
    @IBOutlet weak var tfEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfEmail.layer.cornerRadius = 8
        tfEmail.backgroundColor = UIColor(named: "lightGrey")
        
        addLeftPadding(to: tfEmail)
    }
    
    func addLeftPadding(to textField: UITextField, width: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func btnNextTapped(_ sender: Any) {
        guard let email = tfEmail.text , validateEmail.validateEmail(email) else {
            return
        }
        
        resetPasswordViewModel.resetPassword(email: email) { result in
            switch result {
            case .success(let status):
                Utility.shared.showToast(message: "Email has sent successfully!. Check you mail box.")
                self.navigationController?.popToRootViewController(animated: true)
            case .failure(let error):
                print(error.localizedDescription)
                Utility.shared.showToast(message: error.localizedDescription)
            }
        }
    
    }
    
}
