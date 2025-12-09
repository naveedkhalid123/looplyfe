//
//  CreatePasswordViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 15/02/2025.
//

import UIKit

class CreatePasswordViewController: UIViewController {
    
    var social: String = ""
    var email: String = ""
    var dateOfBirth: String = ""
    
    private var isPasswordVisible = false
    private let viewModel = CreatePasswordViewModel()
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnPreview: UIButton!
    @IBOutlet weak var characterLimitImage: UIImageView!
    @IBOutlet weak var lblCharactersLimit: UILabel!
    @IBOutlet weak var specailCharactersImage: UIImageView!
    @IBOutlet weak var lblSpecailCharacters: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        
        tfPassword.isSecureTextEntry = true
        tfPassword.addTarget(self, action: #selector(passwordDidChange(_:)), for: .editingChanged)
        
        setValidationUI(isValidLength: false, isValidSpecial: false)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func previewBtnTapped(_ sender: Any) {
        isPasswordVisible.toggle()
        
        let wasFirstResponder = tfPassword.isFirstResponder
        let currentText = tfPassword.text
        
        tfPassword.isSecureTextEntry = !isPasswordVisible
        tfPassword.text = currentText
        
        if wasFirstResponder {
            tfPassword.becomeFirstResponder()
        }
        
        let imageName = isPasswordVisible ? "eye.slash" : "eye"
        btnPreview.setImage(UIImage(systemName: imageName), for: .normal)
        btnPreview.tintColor = .gray
    }
    
    // MARK: - Real-time Validation
    @objc func passwordDidChange(_ textField: UITextField) {
        guard let password = textField.text else { return }
        
        let isValidLength = viewModel.isValidLength(password)
        let isValidSpecial = viewModel.isValidContent(password)
        
        setValidationUI(isValidLength: isValidLength, isValidSpecial: isValidSpecial)
    }
    
    // MARK: - UI Update
    private func setValidationUI(isValidLength: Bool, isValidSpecial: Bool) {
        lblCharactersLimit.textColor = isValidLength ? .black : .lightGray
        let lengthImageName = isValidLength ? "checkmark.circle.fill" : "circle"
        characterLimitImage.image = UIImage(systemName: lengthImageName)
        characterLimitImage.tintColor = isValidLength ? .systemGreen : .lightGray
        
        lblSpecailCharacters.textColor = isValidSpecial ? .black : .lightGray
        let specialImageName = isValidSpecial ? "checkmark.circle.fill" : "circle"
        specailCharactersImage.image = UIImage(systemName: specialImageName)
        specailCharactersImage.tintColor = isValidSpecial ? .systemGreen : .lightGray
    }
    
    // MARK: - Next Button
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        guard let password = tfPassword.text, !password.isEmpty else {
            Utility.shared.showToast(message: "Please set your password.")
            return
        }
        
        let isValidLength = viewModel.isValidLength(password)
        let isValidContent = viewModel.isValidContent(password)
        
        if !isValidLength && !isValidContent {
            Utility.shared.showToast(message: "Password must be 8–20 characters long and include letters, numbers, and special characters.")
            return
        } else if !isValidLength {
            Utility.shared.showToast(message: "Password must be 8–20 characters long.")
            return
        } else if !isValidContent {
            Utility.shared.showToast(message: "Password must include at least one letter, one number, and one special character.")
            return
        }
        
        let vc = CreateUserNameViewController(nibName: "CreateUserNameViewController", bundle: nil)
        vc.social = social
        vc.dateOfBirth = self.dateOfBirth
        vc.email = self.email
        vc.password = password
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
