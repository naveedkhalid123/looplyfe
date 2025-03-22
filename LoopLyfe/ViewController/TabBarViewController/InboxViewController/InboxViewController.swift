//
//  InboxViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 17/02/2025.
//

import SDWebImage
import UIKit

class InboxViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var InboxArr = [["Image": "userProfile", "headLbl": "New followers", "subHeadLbl": "Bilal started following you"], ["Image": "userProfile", "headLbl": "System notifications", "subHeadLbl": "Ahmad started following you"], ["Image": "userProfile", "headLbl": "Activity", "subHeadLbl": "Rizwan started following you"], ["Image": "userProfile", "headLbl": "New followers", "subHeadLbl": "Ali started following you"]]
    
    var showAllNotifications = ShowUserDetailViewModel()
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var inboxTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        
        inboxTblView.delegate = self
        inboxTblView.dataSource = self
        inboxTblView.register(UINib(nibName: "InboxTblViewCell", bundle: nil), forCellReuseIdentifier: "InboxTblViewCell")
        
        let param: [String: Any] = [
            "user_id": "9363",
            "starting_point": 0
        ]
        
        // Fetch suggested users
        showAllNotifications.showAllNotifications(parameters: param)
        
        showAllNotifications.onShowAllNotificationsLoaded = { [weak self] _ in
            print("API Response: \(String(describing: self?.showAllNotifications.showAllNotifications))")
            self?.inboxTblView.reloadData()
        }
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showAllNotifications.showAllNotifications?.msg?.count ?? 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InboxTblViewCell") as! InboxTblViewCell
        let showAllNotificationsArr = showAllNotifications.showAllNotifications?.msg?[indexPath.row]
        cell.userImage.sd_setImage(with: URL(string: showAllNotificationsArr?.sender.profilePic ?? ""), placeholderImage: nil, context: nil)
            
        cell.InboxHeadLbl.text = showAllNotificationsArr?.notification.string
        cell.InboxSubHeadLbl.text = showAllNotificationsArr?.notification.type
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
