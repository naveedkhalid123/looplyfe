//
//  FamilyPairingLinkedViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 21/02/2025.
//

import UIKit

class FamilyPairingLinkedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var linkedAccountArr = [["img":"accountImg","accountHead":"mobbincms7","accountSubHead":"mobbincms7"],["img":"addAccount","accountHead":"Add Account","accountSubHead":""],]
    
    var helpingResourcesArr = [["Img":"bulb","lbl":"Digital parenting tips"],]
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var linkedAccTableView: UITableView!
    @IBOutlet weak var helpingResoucesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        
        linkedAccTableView.delegate = self
        linkedAccTableView.dataSource = self
        linkedAccTableView.register(UINib(nibName: "LinkedAccTblViewCell", bundle: nil), forCellReuseIdentifier: "LinkedAccTblViewCell")
        
        helpingResoucesTableView.delegate = self
        helpingResoucesTableView.dataSource = self
        helpingResoucesTableView.register(UINib(nibName: "HelpingResourcesTableViewCell", bundle: nil), forCellReuseIdentifier: "HelpingResourcesTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == linkedAccTableView {
            return linkedAccountArr.count
        } else {
            return helpingResourcesArr.count
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == linkedAccTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LinkedAccTblViewCell", for: indexPath) as! LinkedAccTblViewCell
            cell.linkedAccImage.image = UIImage(named: linkedAccountArr[indexPath.row]["img"] ?? "")
            cell.accountHeadLbl.text = linkedAccountArr[indexPath.row]["accountHead"]
            cell.accountSubHeadLbl.text = linkedAccountArr[indexPath.row]["accountSubHead"]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HelpingResourcesTableViewCell", for: indexPath) as! HelpingResourcesTableViewCell
            cell.resourcesImage.image = UIImage(named: helpingResourcesArr[indexPath.row]["Img"] ?? "")
            cell.resourcesLbl.text = helpingResourcesArr[indexPath.row]["lbl"]
            return cell
        }
        
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == linkedAccTableView {
            return 80
        } else {
            return 60
        }
    }

}
