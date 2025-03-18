////
////  FollowerViewController.swift
////  LoopLyfe
////
////  Created by Naveed Khalid on 17/03/2025.
////
//



import UIKit
import SDWebImage

class FollowerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var showSuggestionUsers = ShowUserDetailViewModel()

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var followerTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        
        followerTblView.delegate = self
        followerTblView.dataSource = self
        followerTblView.register(UINib(nibName: "FollowerTblViewCell", bundle: nil), forCellReuseIdentifier: "FollowerTblViewCell")
        
        // Corrected Dictionary Format
        let param: [String: Any] = [
            "user_id": "1000",
            "other_user_id": "500",
            "starting_point": "0"
        ]
        
        // Fetch suggested users
        showSuggestionUsers.showSuggestionUsers(parameters: param)
        
        showSuggestionUsers.onnShowSuggestionUsersLoaded = { [weak self] success in
            print("API Response: \(String(describing: self?.showSuggestionUsers.showSuggestionUsers))")
            self?.followerTblView.reloadData()
        }
    }

    
    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showSuggestionUsers.showSuggestedUsers?.msg?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerTblViewCell", for: indexPath) as! FollowerTblViewCell
         
        let showSuggestionUsersArr = showSuggestionUsers.showSuggestedUsers?.msg?[indexPath.row]
        
        cell.followerImage.sd_setImage(with: URL(string: showSuggestionUsersArr?.user.profilePic ?? ""), placeholderImage: nil, context: nil)
        cell.lblFollower.text = showSuggestionUsersArr?.user.username
        let fullName = (showSuggestionUsersArr?.user.firstName ?? "") + " " + (showSuggestionUsersArr?.user.lastName ?? "")

        cell.lblDescription.text = "Follow you \(fullName)"
        
        //add target
        //.tag = indexPath.row

        return cell
    }
    
    //action
    
    
    
    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
