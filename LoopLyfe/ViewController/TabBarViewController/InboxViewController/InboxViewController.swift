//
//  InboxViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 17/02/2025.
//

import SDWebImage
import UIKit
import SkeletonView

class InboxViewController: UIViewController {
    var viewModel = NotificationsViewModel()
    private var startPoint = 0
    
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var inboxTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    //MARK: - FUNCTIONS
    private func setup() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        
        inboxTblView.delegate = self
        inboxTblView.dataSource = self
        inboxTblView.register(UINib(nibName: "InboxTblViewCell", bundle: nil), forCellReuseIdentifier: "InboxTblViewCell")
        inboxTblView.register(UINib(nibName: "VideoNotificationCell", bundle: nil), forCellReuseIdentifier: "VideoNotificationCell")
        inboxTblView.rowHeight = 70
        viewModel.delegate = self
        viewModel.fetchNotifications(startPoint: startPoint)
        inboxTblView.showAnimatedGradientSkeleton()
    }
    
    //MARK: - BUTTON ACTION
        
    
}

//MARK: - TABLE VIEW

extension InboxViewController:  UITableViewDataSource, UITableViewDelegate ,  SkeletonTableViewDataSource {
    
    // skeletonView setup
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        if indexPath.row % 2 == 0 {
            return "InboxTblViewCell"
        } else {
            return "VideoNotificationCell"
        }
    }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notifications.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let showNotifications = viewModel.notifications[indexPath.row].notification
        let sender = viewModel.notifications[indexPath.row].sender
        let video = viewModel.notifications[indexPath.row].video

        if showNotifications.type == "following" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InboxTblViewCell") as! InboxTblViewCell
            if sender.firstName != "" {
                cell.InboxHeadLbl.text = sender.firstName + " " + sender.lastName
            }else {
                cell.InboxHeadLbl.text = sender.username
            }
           
            cell.InboxSubHeadLbl.text = showNotifications.string
            
            let url = URL(string: sender.profilePic)
            cell.userImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoNotificationCell") as! VideoNotificationCell
            if sender.firstName != "" {
                cell.lblHeading.text = sender.firstName + " " + sender.lastName
            }else {
                cell.lblSubHeading.text = sender.username
            }
            cell.lblSubHeading.text = showNotifications.string
            
            let url = URL(string: sender.profilePic)
            cell.profileImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            
            let videoUrl = URL(string: video?.thum ?? "")
            cell.videoThumbImage.sd_setImage(with: videoUrl, placeholderImage: UIImage(named: "placeholder"))
            
            return cell
        }
      
    }
}


//MARK: - DELEGATE
extension InboxViewController: NotificationsUpdater {
    func didUpdateNotifications(_ notifications: [ShowAllNotificationsMsg]) {
        DispatchQueue.main.async {
            if self.startPoint == 0 {
                self.lblNoData.isHidden = !notifications.isEmpty
            } else {
                self.lblNoData.isHidden = true
            }
            self.inboxTblView.reloadData()
            // Hide skeletion
            self.inboxTblView.hideSkeleton()
        }
    }
    
    func didFailToUpdateNotifications(error: Error) {
        DispatchQueue.main.async {
            print("error",error.localizedDescription)
            // Hide skeletion
            self.inboxTblView.hideSkeleton()
        }
    }
    
}
