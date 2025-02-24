//
//  Extension.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 14/02/2025.
//

import Foundation
import UIKit

extension UIView {
    // OUTPUT 1
    func dropShadow(color: UIColor) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 1
    }
}

extension UserDefaults {
    // Save data
    func saveData(forKey key: String, value: String) {
        set(value, forKey: key)
    }

    // Retrieve data
    func retreiveData(forKey key: String) -> String? {
        return string(forKey: key) ?? ""
    }
}

extension UIViewController {
    func showAlert(message: String, title: String = "Message") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

enum AssetsFont: String {
    case SFProDisplayThin = "SF-Pro-Display-Thin"
    case SFProDisplayLight = "SF-Pro-Display-Light"
    case SFProDisplayRegular = "SF-Pro-Display-Regular"
    case SFProDisplayBold = "SF-Pro-Display-Bold"
    case SFProDisplayMedium = "SF-Pro-Display-Medium"
    case SFProDisplayHeavy = "SF-Pro-Display-Heavy"
    case SFProDisplaySemibold = "SF-Pro-Display-Semibold"
    case SFProDisplayUltralight = "SF-Pro-Display-Ultralight"
    case SFProDisplayBlack = "SF-Pro-Display-Black"
}

extension UIFont {
    static func appFont(_ name: AssetsFont, size: CGFloat) -> UIFont? {
        return UIFont(name: name.rawValue, size: size)
    }
}

enum AssetsColor: String {
    case black
    case darkTxtGrey
    case grey
    case lightGrey
    case shdow
    case textGrey
    case yellow
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}

// Code for screen Height and screen Type regarding different screens

public extension UIDevice {
    var iPhone: Bool { UIDevice.current.userInterfaceIdiom == .phone }
    var iPad: Bool { UIDevice().userInterfaceIdiom == .pad }

    enum ScreenType: String {
        case iphone_8 = "iPhone 8"
        case iphone_8Plus = "iPhone 8 Plus"
        case iphone_SE3 = "iPhone SE (3rd generation)"
        case iphone_X_XS = "iPhone X or iPhone XS"
        case iphone_XR_11 = "iPhone XR or iPhone 11"
        case iphone_XSMax_ProMax = "iPhone XS Max or iPhone 11 Pro Max or iPhone 12 Pro Max or iPhone 13 Pro Max or iPhone 14 Plus"
        case iphone_11Pro = "iPhone 11 Pro"
        case iphone_12_12Pro_13_13Pro_14 = "iPhone 12 or 12 Pro or 13 or 13 Pro or 14"
        case iphone_14Pro = "iPhone 14 Pro"
        case iphone_14ProMax = "iPhone 14 Pro Max"
        case iphone12Mini_13Mini = "iPhone 12 Mini or 13 Mini"
        case unknown
    }

    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }

    var screenType: ScreenType {
        guard iPhone else { return .unknown }

        switch screenHeight {
        case 667: // iPhone 8, iPhone 7, iPhone 6s, iPhone 6,iPhone SE
            return .iphone_8
        case 736: // iPhone 8 Plus, iPhone 7 Plus, iPhone 6s Plus, iPhone 6 Plus
            return .iphone_8Plus
        case 734: // iPhone SE (3rd generation)
            return .iphone_SE3
        case 812: // iPhone X, XS, 11 Pro
            return .iphone_X_XS
        case 896: // iPhone XR, 11
            return .iphone_XR_11
        case 844: // iPhone 12, 12 Pro, 13, 13 Pro, 14
            return .iphone_12_12Pro_13_13Pro_14
        case 2532: // iPhone 14 Pro
            return .iphone_14Pro
        case 2796: // iPhone 14 Pro Max
            return .iphone_14ProMax
        case 2340: // iPhone 12 Mini, 13 Mini
            return .iphone12Mini_13Mini
        default:
            return .unknown
        }
    }
}
