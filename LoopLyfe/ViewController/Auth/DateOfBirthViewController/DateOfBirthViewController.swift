//
//  DateOfBirthViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 15/02/2025.
//

import UIKit
import Toast_Swift

class DateOfBirthViewController: UIViewController {
  
    var social: String = ""
  
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet weak var tfBirthday: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear

        datePicker.maximumDate = Date()
        datePicker.datePickerMode = .date
        
    
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }

    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
     
        guard let birthday = tfBirthday.text , !birthday.isEmpty else {
            Utility.shared.showToast(message: "Please select your data of birth.")
            return
        }
        
        if social == "google" {
            let vc = CreateUserNameViewController(nibName: "CreateUserNameViewController", bundle: nil)
            vc.social = social
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = SignInWithEmailAndPhone(nibName: "SignInWithEmailAndPhone", bundle: nil)
            vc.dateOfBirth = birthday
            self.navigationController?.pushViewController(vc, animated: true)
        }
    
    }
    
    @IBAction func datePickerSelected(_ sender: UIDatePicker) {
        updateBirthdayField(with: sender.date)
    }
    
    // MARK: - Helper Method
    private func updateBirthdayField(with date: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        let formattedDate = formatter.string(from: date)
        tfBirthday.text = formattedDate
    }
}
