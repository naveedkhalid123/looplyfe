//
//  Onbording2ViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 14/02/2025.
//

import UIKit

class Onbording2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var ineterstTblArr = ["Music", "Culture", "Weather"]
 
    @IBOutlet var skipButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var interestsTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skipButton.layer.cornerRadius = 2
        skipButton.layer.borderWidth = 1
        skipButton.layer.borderColor = UIColor(named: "lightGrey")?.cgColor
        
        nextButton.layer.cornerRadius = 2
        
        interestsTabelView.delegate = self
        interestsTabelView.dataSource = self
        interestsTabelView.register(UINib(nibName: "InterestTblViewCell", bundle: nil), forCellReuseIdentifier: "InterestTblViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ineterstTblArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InterestTblViewCell", for: indexPath) as! InterestTblViewCell
        cell.interestLbl.text = ineterstTblArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
