//
//  ManageThisAccountViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/02/2025.
//

import UIKit

class ManageThisAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var manageAccArr = [["img":"clock","head":"Screen Time Management","subHead":"Off"],["img":"filter","head":"Restricted Mode","subHead":"Off"],["img":"searchAcc","head":"Search","subHead":"On"],["img":"safety","head":"Privacy and safety","subHead":""],]
  
    

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var manageThisAccTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        
        manageThisAccTableView.delegate = self
        manageThisAccTableView.dataSource = self
        manageThisAccTableView.register(UINib(nibName: "ManageThisAccTblViewCell", bundle: nil), forCellReuseIdentifier: "ManageThisAccTblViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manageAccArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageThisAccTblViewCell") as! ManageThisAccTblViewCell
        cell.manageThisImages.image = UIImage(named: manageAccArr[indexPath.row]["img"] ?? "")
        cell.manageThisLbl.text = manageAccArr[indexPath.row]["head"]
        cell.offLbl.text = manageAccArr[indexPath.row]["subHead"]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

}
