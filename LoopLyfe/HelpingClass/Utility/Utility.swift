//
//  Utility.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 05/03/2025.
//


import Foundation
import PhoneNumberKit
import Toast_Swift


class Utility {
    // Singleton instance
    static let shared = Utility()
    
    // For phone number , we declared the code in utility and declare a fucntion and variable
    let phoneNumberKit: PhoneNumberKit
    private init() {
        phoneNumberKit = PhoneNumberKit()
    }
    

    func imageUnicode(emoji: String, imageView: UIImageView) -> UIImage? {
        let size = imageView.bounds.size
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        
        let fontSize = min(size.width, size.height)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontSize)
        ]
        
        let textSize = emoji.size(withAttributes: attributes)
        let rect = CGRect(x: (size.width - textSize.width) / 2,
                          y: (size.height - textSize.height) / 2,
                          width: textSize.width,
                          height: textSize.height)
        emoji.draw(in: rect, withAttributes: attributes)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    
    // Validate email format using if-else
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        if emailPred.evaluate(with: email) {
            return false
        } else {
            return true
        }
    }
    
    // Check if string is empty or contains only whitespace using if-else
    func isEmpty(_ text: String) -> Bool {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedText.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    
   
    func isValidPhoneNumber(_ strPhone: String, region: String) -> Bool {
        do {
            // Parse the phone number with the specified region
            _ = try Utility.shared.phoneNumberKit.parse(strPhone, withRegion: region, ignoreType: false)
            return false
        } catch {
            print("Phone number validation error: \(error)")
            return true
        }
    }
    
    
    
    // For firebase authentication toast
    func getKeyWindow() -> UIWindow? {
            UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        }
        
        func showToast(message: String) {
            guard let window = getKeyWindow() else {
                print("Unable to find key window for toast.")
                return
            }
            window.makeToast(message)
        }
        
        func showToastActivity() {
            guard let window = getKeyWindow() else {
                print("Unable to find key window for toast activity.")
                return
            }
            window.makeToastActivity(.center)
        }
        
        func hideToastActivity() {
            guard let window = getKeyWindow() else {
                print("Unable to find key window to hide toast activity.")
                return
            }
            window.hideToastActivity()
        }
        
        func hideAllToasts() {
            guard let window = getKeyWindow() else {
                print("Unable to find key window to hide toasts.")
                return
            }
            window.hideAllToasts()
        }
}






