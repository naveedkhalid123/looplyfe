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

//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        print("Selected \(viewController)")
//    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select \(viewController)?")
        return true // Return false to prevent selection
    }
}
