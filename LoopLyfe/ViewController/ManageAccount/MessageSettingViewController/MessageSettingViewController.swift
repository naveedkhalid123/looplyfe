//
//  MessageSettingViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/02/2025.
//

import UIKit

class MessageSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var messageSettingArr = [["head":"Welcome message","subHead":"Welcome message","desc":"Auto-reply when users start a direct message"],["head":"Key-word auto-reply","subHead":"Keyword- auto-reply","desc":"Custome auto-reply when user message specific keywords"]]
    
    @IBOutlet weak var messageSettingTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageSettingTblView.delegate = self
        messageSettingTblView.dataSource = self
        messageSettingTblView.register(UINib(nibName: "MessageSettingTblViewCell", bundle: nil), forCellReuseIdentifier: "MessageSettingTblViewCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageSettingArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageSettingTblViewCell", for: indexPath) as! MessageSettingTblViewCell
        cell.messageHeadLbl.text = messageSettingArr[indexPath.row]["head"]
        cell.messageSubHeadLbl.text = messageSettingArr[indexPath.row]["subHead"]
        cell.messageDesc.text = messageSettingArr[indexPath.row]["desc"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}
