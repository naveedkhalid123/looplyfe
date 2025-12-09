//
//  DurationViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 24/02/2025.
//

import UIKit

class DurationViewController: UIViewController {
    @IBOutlet var budgetLbl: UILabel!

    @IBOutlet var budgetPerDayLbl: UILabel!
    @IBOutlet var budgetSlider: UISlider!

    @IBOutlet var durationDays: UILabel!
    @IBOutlet var durationSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()

        let thumbImage = createThumbImage(size: CGSize(width: 20, height: 20), color: UIColor.appColor("yellow"))

        budgetSlider.setThumbImage(thumbImage, for: .normal)
        durationSlider.setThumbImage(thumbImage, for: .normal)
    }

    func createThumbImage(size: CGSize, color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            let rect = CGRect(origin: .zero, size: size)
            color.setFill()
            UIBezierPath(ovalIn: rect).fill()
        }
    }

    @IBAction func budgetSliderPressed(_ sender: UISlider) {}

    @IBAction func durationSliderPressed(_ sender: UISlider) {}
    
    @IBAction func backBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
    
    }
    
    
}

extension UIColor {
    static func appColor(_ name: String) -> UIColor {
        return UIColor(named: "yellow") ?? .yellow
    }
}
