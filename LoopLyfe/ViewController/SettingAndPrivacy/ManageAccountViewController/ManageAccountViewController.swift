//
//  ManageAccountViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/02/2025.
//

import UIKit

class ManageAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var manageAccountArr = [["lbl": "Phone number", "value": "+65*****988"], ["lbl": "Email", "value": ""], ["lbl": "Date of birth", "value": "18 Feb 1995"], ["lbl": "Password", "value": ""], ["lbl": "Switch to Business Account", "value": ""], ["lbl": "Delete account", "value": ""]]

    @IBOutlet var manageAccountTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        manageAccountTblView.delegate = self
        manageAccountTblView.dataSource = self
        manageAccountTblView.register(UINib(nibName: "ManageAccTblViewCell", bundle: nil), forCellReuseIdentifier: "ManageAccTblViewCell")
        manageAccountTblView.rowHeight = 60
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manageAccountArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageAccTblViewCell", for: indexPath) as! ManageAccTblViewCell
        cell.manageAccLbl.text = manageAccountArr[indexPath.row]["lbl"]
        cell.manageAccValue.text = manageAccountArr[indexPath.row]["value"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            let settingsVC = BusinessViewController(nibName: "BusinessViewController", bundle: nil)
            navigationController?.pushViewController(settingsVC, animated: true)
        }
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
