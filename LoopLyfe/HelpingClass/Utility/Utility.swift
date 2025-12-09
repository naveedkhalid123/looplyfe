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
    
    static func isValidPhoneNumber(_ strPhone: String, region: String) -> Bool {
        do {
            _ = try self.shared.phoneNumberKit.parse(strPhone, withRegion: region)
            return true
        } catch {
            print("Generic parser error")
            return false
        }
    }
    
    func isEmpty(_ text: String) -> Bool {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedText.isEmpty { return true } else {
            return false } }
    
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
    
    func generateRandomUsername() -> String {
        let randomNumber = Int.random(in: 1000...99999)
        let username = "Apple_user\(randomNumber)"
        return username
    }
    
    func splitUsername(_ username: String) -> (firstName: String, lastName: String) {
        let components = username.split(separator: "_", maxSplits: 1).map { String($0) }
        
        let firstName = components.first ?? ""
        let lastName = components.count > 1 ? components[1] : ""
        
        return (firstName, lastName)
    }
    
    // MARK: - Loader
    internal func createActivityIndicator(_ uiView: UIView) -> UIView {
            let container = UIView()
            container.translatesAutoresizingMaskIntoConstraints = false
            container.backgroundColor = UIColor(white: 0.2, alpha: 0.6)
            
            uiView.addSubview(container)
            NSLayoutConstraint.activate([
                container.topAnchor.constraint(equalTo: uiView.topAnchor),
                container.bottomAnchor.constraint(equalTo: uiView.bottomAnchor),
                container.leadingAnchor.constraint(equalTo: uiView.leadingAnchor),
                container.trailingAnchor.constraint(equalTo: uiView.trailingAnchor)
            ])
            
            let loadingView = UIView()
            loadingView.translatesAutoresizingMaskIntoConstraints = false
            loadingView.backgroundColor = UIColor.clear
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 15
            loadingView.layer.shadowRadius = 5
            loadingView.layer.shadowOffset = CGSize(width: 0, height: 4)
            loadingView.layer.opacity = 2
            loadingView.layer.masksToBounds = false
            
            container.addSubview(loadingView)
            NSLayoutConstraint.activate([
                loadingView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                loadingView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                loadingView.widthAnchor.constraint(equalToConstant: 80),
                loadingView.heightAnchor.constraint(equalToConstant: 80)
            ])
            
            let actInd = UIActivityIndicatorView(style: .large)
            actInd.translatesAutoresizingMaskIntoConstraints = false
            actInd.color = UIColor(named: "yellow")
            actInd.startAnimating()
            
            loadingView.addSubview(actInd)
            NSLayoutConstraint.activate([
                actInd.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
                actInd.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
            ])
            
            container.isHidden = true
            return container
        }
    
}






