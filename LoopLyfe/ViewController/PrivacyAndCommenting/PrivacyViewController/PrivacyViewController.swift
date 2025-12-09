//
//  PrivacyViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 25/02/2025.
//

import UIKit

class PrivacyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var privacyArr = [["head": "Private account", "desc": "With a private account, only accounts you approve can follow you."]]
    var syncContantsArr = ["Sync contacts account to others","Sync contacts and Facebook friends","Location services"]
    var personlizeArr = [["head":"Ads personalization","desc":""],["head":"Download your data","desc":"Get a copy y of your LoopLyfe data"],]
    var safetyArr = [["Image":"downloadIcon","lbl":"Downloads","desc": "On"],["Image":"commentIcon","lbl":"Comments","desc": ""],["Image":"mention","lbl":"Mentions","desc": ""],["Image":"followingIcon","lbl":"Following list","desc": "Everyone"],["Image":"love","lbl":"Duet","desc": "Everyone"],["Image":"book","lbl":"Stitch","desc": "Everyone"],["Image":"likedIcon","lbl":"Liked videos","desc": "Only me"],["Image":"dmIcon","lbl":"Direct messages","desc": ""],["Image":"block","lbl":"Blocked accounts","desc": ""],["Image":"views","lbl":"Profile views","desc": "On"],]
    
    @IBOutlet var privacyAccountTblView: UITableView!
    @IBOutlet weak var syncContactsTblView: UITableView!
    @IBOutlet weak var personalizeTblView: UITableView!
    @IBOutlet weak var safetyTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        privacyAccountTblView.delegate = self
        privacyAccountTblView.dataSource = self
        privacyAccountTblView.register(UINib(nibName: "FiltersTblViewCell", bundle: nil), forCellReuseIdentifier: "FiltersTblViewCell")
        
        syncContactsTblView.delegate = self
        syncContactsTblView.dataSource = self
        syncContactsTblView.register(UINib(nibName: "SyncContactsTblViewCell", bundle: nil), forCellReuseIdentifier: "SyncContactsTblViewCell")
        
        personalizeTblView.delegate = self
        personalizeTblView.dataSource = self
        personalizeTblView.register(UINib(nibName: "PersonalizeTblViewCell", bundle: nil), forCellReuseIdentifier: "PersonalizeTblViewCell")
        
        safetyTblView.delegate = self
        safetyTblView.dataSource = self
        safetyTblView.register(UINib(nibName: "SafetyTblViewCell", bundle: nil), forCellReuseIdentifier: "SafetyTblViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == privacyAccountTblView {
            return privacyArr.count
        } else if tableView == syncContactsTblView {
            return syncContantsArr.count
        } else if  tableView == personalizeTblView {
            return personlizeArr.count
        } else {
            return safetyArr.count
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == privacyAccountTblView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FiltersTblViewCell", for: indexPath) as! FiltersTblViewCell
            cell.filterHeadLbl.text = privacyArr[indexPath.row]["head"]
            cell.filterDesc.text = privacyArr[indexPath.row]["desc"]
            return cell
        } else  if tableView == syncContactsTblView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SyncContactsTblViewCell", for: indexPath) as! SyncContactsTblViewCell
            cell.syncLbl.text = syncContantsArr[indexPath.row]
            return cell
        } else  if  tableView == personalizeTblView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalizeTblViewCell", for: indexPath) as! PersonalizeTblViewCell
            cell.personalizeHead.text = personlizeArr[indexPath.row]["head"]
            cell.personalizeDesc.text = personlizeArr[indexPath.row]["desc"]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SafetyTblViewCell", for: indexPath) as! SafetyTblViewCell
            cell.safetyImage.image = UIImage(named: safetyArr[indexPath.row]["Image"] ?? "")
            cell.safetyLbl.text = safetyArr[indexPath.row]["lbl"]
            cell.safetyDesc.text = safetyArr[indexPath.row]["desc"]
            return cell
        }
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == privacyAccountTblView {
            return 80
        } else if tableView == syncContactsTblView {
            return 60
        } else if  tableView == personalizeTblView {
            return 55
        } else {
            return 54
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == safetyTblView {
            if indexPath.row == 1 {
                let settingsVC = CommentsViewController(nibName: "CommentsViewController", bundle: nil)
                navigationController?.pushViewController(settingsVC, animated: true)
            }
        }
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
