//
//  OTPVerificationViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 15/02/2025.
//

import DPOTPView
import UIKit

class OTPVerificationViewController: UIViewController, DPOTPViewDelegate {
    
    var isSignIn = false
    var phoneNumber: String = ""
    
    var verificationId = ""
    var signinEmailPhoneViewModel = SigninEmailPhoneViewModel()
    
    var siginViewModel = SigninViewModel()
    
    private lazy var loader: UIView = {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow })
        else {
            fatalError("Unable to access key window")
        }
        return Utility.shared.createActivityIndicator(keyWindow)
    }()
    
    @IBOutlet var navigationBar: UINavigationBar!
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet var OTPView: DPOTPView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.message.text = "Your code was sent to \(phoneNumber)"
        
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
    
    private func verifyOTP(otpCode: String){
        self.loader.isHidden = false
        signinEmailPhoneViewModel.verifyOTP(verificationID: self.verificationId, otpCode: otpCode) { result in
            self.loader.isHidden = true
            switch result {
            case .success(let uid):
                // sign in hu chuka hai
                UserDefaultsManager.shared.authToken = uid
                self.siginViewModel.showUserDetail { result in
                    switch result {
                    case .success(let status):
                        UserDefaultsManager.shared.userId = status.msg?.user?.id?.toString() ?? "0"
                        if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
                            appdelegate.goToHomeViewController()
                        }
                    case .failure(let error):
                        Utility.shared.showToast(message: error.localizedDescription)
                    }
                }
               
            case .failure(let error):
                Utility.shared.showToast(message: error.localizedDescription)
            }
        }
    }
    

    func dpOTPViewAddText(_ text: String, at position: Int) {
        if position <= 5 && text.count == 6 {
            self.verifyOTP(otpCode: text)
        }
    }
    
    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        if position <= 5 && text.count == 6 {
            self.verifyOTP(otpCode: text)
        }
    }
    
    func dpOTPViewChangePositionAt(_ position: Int) {}
    
    func dpOTPViewBecomeFirstResponder() {}
    
    func dpOTPViewResignFirstResponder() {}
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
