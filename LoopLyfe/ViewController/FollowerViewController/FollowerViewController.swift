////
////  FollowerViewController.swift
////  LoopLyfe
////
////  Created by Naveed Khalid on 17/03/2025.
////
//



import UIKit
import SDWebImage

class FollowerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    var followerLblArr = ["Following","Followers","Friends","Suggestions"]
    var followedUsers: Set<Int> = [] // Store indexes of followed users
    var showFollowing: Set<Int> = []
    
    
    /// Call the view model in a variable
    private var showSuggestionUsers = ShowUserDetailViewModel()
    

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var followerCollectionView: UICollectionView!
    
    @IBOutlet weak var followerTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        
        followerCollectionView.delegate = self
        followerCollectionView.dataSource = self
        followerCollectionView.register(UINib(nibName: "FollowerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FollowerCollectionViewCell")
        
        followerTblView.delegate = self
        followerTblView.dataSource = self
        followerTblView.register(UINib(nibName: "FollowerTblViewCell", bundle: nil), forCellReuseIdentifier: "FollowerTblViewCell")
        
//        // Corrected Dictionary Format
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
//        
//        
//        let param: [String: Any] = [
//            "user_id": "9363",
//            "starting_point": 0
//        ]
//        
//        // Fetch suggested users
//        showSuggestionUsers.showFollowingUser(parameters: param)
//        
//        showSuggestionUsers.onShowFollowingUserLoaded = { [weak self] success in
//            print("API Response: \(String(describing: self?.showSuggestionUsers.showFollowingUser))")
//            self?.followerTblView.reloadData()
//        }
        
        
        
//        let param: [String: Any] = [
//            "user_id": "9363",
//            "starting_point": 0
//        ]
//        
//        // Fetch suggested users
//        showSuggestionUsers.showFollowersUser(parameters: param)
//        
//        showSuggestionUsers.onShowFollowersUserLoaded = { [weak self] success in
//            print("API Response: \(String(describing: self?.showSuggestionUsers.showFollowersUser))")
//            self?.followerTblView.reloadData()
//        }
//        
        



    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followerLblArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowerCollectionViewCell", for: indexPath) as! FollowerCollectionViewCell
        cell.lblFollowers.text = followerLblArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4, height: 40)
    }
    var selectedIndex: IndexPath?

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Deselect the previous selected cell
        if let previousIndex = selectedIndex, let previousCell = collectionView.cellForItem(at: previousIndex) as? FollowerCollectionViewCell {
            previousCell.lblFollowers.textColor = .gray
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? FollowerCollectionViewCell {
            cell.lblFollowers.textColor = .black
        }
        selectedIndex = indexPath
    }


    
    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1st api
         return showSuggestionUsers.showSuggestedUsers?.msg?.count ?? 0
        // 2nd api
        //return showSuggestionUsers.showFollowingUser?.msg?.count ?? 0
        
        //return showSuggestionUsers.showFollowerUser?.msg?.count ?? 0
        
        


    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerTblViewCell", for: indexPath) as! FollowerTblViewCell
        
        // 1st api
         
        let showSuggestionUsersArr = showSuggestionUsers.showSuggestedUsers?.msg?[indexPath.row]
        
        cell.followerImage.sd_setImage(with: URL(string: showSuggestionUsersArr?.user.profilePic ?? ""), placeholderImage: nil, context: nil)
        cell.lblFollower.text = showSuggestionUsersArr?.user.username
        let fullName = (showSuggestionUsersArr?.user.firstName ?? "") + " " + (showSuggestionUsersArr?.user.lastName ?? "")
        cell.lblDescription.text = "Follow you \(fullName)"
        
        
        
//        // 2nd api
//        let showFollowingUSersArr = showSuggestionUsers.showFollowingUser?.msg?[indexPath.row]
//        cell.followerImage.sd_setImage(with: URL(string: showFollowingUSersArr?.user.profilePic ?? ""), placeholderImage: nil, context: nil)
//        cell.lblFollower.text = showFollowingUSersArr?.user.username
//        let fullName = (showFollowingUSersArr?.user.firstName ?? "") + " " + (showFollowingUSersArr?.user.lastName ?? "")
//        cell.lblDescription.text = "Follow you \(fullName)"
        
        
        // 3rd api
//        let showFollowersUSersArr = showSuggestionUsers.showFollowerUser?.msg?[indexPath.row]
//        cell.followerImage.sd_setImage(with: URL(string: showFollowersUSersArr?.user.profilePic ?? ""), placeholderImage: nil, context: nil)
//        cell.lblFollower.text = showFollowersUSersArr?.user.username
//        let fullName = (showFollowersUSersArr?.user.firstName ?? "") + " " + (showFollowersUSersArr?.user.lastName ?? "")
//        cell.lblDescription.text = "Follow you \(fullName)"
      
    
        cell.btnFollowBack.tag = indexPath.row
        cell.btnFollowBack.addTarget(self, action: #selector(btnFollowBackPressed(_:)), for: .touchUpInside)
        cell.btnDismiss.tag = indexPath.row
        cell.btnDismiss.addTarget(self, action: #selector(dismissBtnPressed(_:)), for: .touchUpInside)

        return cell
    }
    
  

 
    @objc func btnFollowBackPressed(_ sender: UIButton) {
        let index = sender.tag
        let senderId = showSuggestionUsers.showSuggestedUsers?.msg?[index].user.id ?? 0

        let parameters: [String: Any] = [
            "sender_id": String(senderId),
            "receiver_id": "1000"
        ]

        ApiManager.shared.apiRequest(endpoint: .followUser, parameters: parameters) { [weak self] (result: Result<FollowUserModel, Error>) in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("✅ Follow API Success:", response)
                    let user = response.msg.user
                    if user.button == "follow" {
                        sender.setTitleColor(UIColor.white, for: .normal)
                        sender.backgroundColor = UIColor(named: "yellow") ?? .yellow
                        sender.setTitle("Follow", for: .normal)
                    }else{
                        sender.backgroundColor = UIColor(named: "lightGrey") ?? .yellow
                        sender.setTitleColor(UIColor.black, for: .normal)
                        sender.setTitle("Following", for: .normal)
                    }
                   
                case .failure(let error):
                    print("❌ Follow API failed:", error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
//    @objc func btnFollowBackPressed(_ sender: UIButton) {
//        let parameters: [String: Any] = [
//            "user_id": "9363",
//            "starting_point": 0
//        ]
//
//        ApiManager.shared.apiRequest(endpoint: .showFollowing, parameters: parameters) { [weak self] (result: Result<ShowFollowingModel, Error>) in
//            guard let self = self else { return }
//            print("API Response: \(result)")
//        }
//    }

    
    
    @objc func dismissBtnPressed(_ sender: UIButton) {
            let index = sender.tag
            
            // Ensure the index is within bounds
            guard var users = showSuggestionUsers.showSuggestedUsers?.msg, index < users.count else { return }
            
            let senderId = users[index].user.id ?? 0
            
            // Remove the user from the list
            users.remove(at: index)
            showSuggestionUsers.showSuggestedUsers?.msg = users
            
            // Reload the tableView with animation
            followerTblView.performBatchUpdates({
                let indexPath = IndexPath(row: index, section: 0)
                followerTblView.deleteRows(at: [indexPath], with: .fade)
            }) { _ in
                self.followerTblView.reloadData()
            }
        }


    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    
}
