//
//  TabBarViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 17/02/2025.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
            print("Should select tab index: \(index)")
            
            if index == 1 {
                // Check login status
                if UserDefaultsManager.shared.authToken == "" {
                    DispatchQueue.main.async { [weak self] in
                        self?.goToSignInViewController()
                    }
                    return false
                }
            }
        }
        return true
    }


    
    func goToSignInViewController() {
        let vc = SignInViewController(nibName: "SignInViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.isNavigationBarHidden = true
        navigationController.modalPresentationStyle = .overFullScreen
       
        self.present(navigationController, animated: true, completion: nil)
    }

}
