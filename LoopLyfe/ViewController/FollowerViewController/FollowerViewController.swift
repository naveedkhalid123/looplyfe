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
        
        // Select the new cell
        if let cell = collectionView.cellForItem(at: indexPath) as? FollowerCollectionViewCell {
            cell.lblFollowers.textColor = .black
        }
        
        // Update selected index
        selectedIndex = indexPath
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
        

        // Add target and set tag
        cell.btnFollowBack.tag = indexPath.row
        cell.btnFollowBack.addTarget(self, action: #selector(btnFollowBackPressed(_:)), for: .touchUpInside)

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

 


    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
