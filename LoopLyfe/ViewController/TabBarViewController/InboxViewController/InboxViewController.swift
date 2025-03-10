//
//  InboxViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 17/02/2025.
//

import UIKit

class InboxViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var InboxArr = [["Image": "userProfile","headLbl":"New followers","subHeadLbl":"Bilal started following you"],["Image": "userProfile","headLbl":"System notifications","subHeadLbl":"Ahmad started following you"],["Image": "userProfile","headLbl":"Activity","subHeadLbl":"Rizwan started following you"],["Image": "userProfile","headLbl":"New followers","subHeadLbl":"Ali started following you"],]

    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var inboxTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        
        inboxTblView.delegate = self
        inboxTblView.dataSource = self
        inboxTblView.register(UINib(nibName: "InboxTblViewCell", bundle: nil), forCellReuseIdentifier: "InboxTblViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InboxArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InboxTblViewCell") as! InboxTblViewCell
        cell.userImage.image = UIImage(named: InboxArr[indexPath.row]["Image"] ?? "")
        cell.InboxHeadLbl.text  = InboxArr[indexPath.row]["headLbl"]
        cell.InboxSubHeadLbl.text = InboxArr[indexPath.row]["subHeadLbl"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    

}
