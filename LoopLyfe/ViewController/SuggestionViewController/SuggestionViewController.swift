//
//  SuggestionViewController.swift
//  LoopLyfe
//
//  Created by iMac on 24/10/2025.
//


import UIKit
import SDWebImage

class SuggestionViewController: UIViewController {

    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var suggestionCollectionView: UICollectionView!
    @IBOutlet weak var suggestionSearchBar: UISearchBar!
    @IBOutlet weak var suggestionTableView: UITableView!
    
    private var suggestionArr = ["Following 1", "Followers", "Friends", "Suggestion"]
    private var userSuggestionArr = [["image": "userProfile","lblName": "Naveed", "lblDesc": "hahahaha"],["image": "userProfile","lblName": "Naveed", "lblDesc": "hahahaha"],["image": "userProfile","lblName": "Naveed", "lblDesc": "hahahaha"],]
    
    var selectedIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    var showSuggestionUsers = ShowUserDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
       // MARK: SHOW SUGGSTION
        let param: [String: Any] = [
            "user_id": "1000",
            "other_user_id": "500",
            "starting_point": "0"
        ]
        
        
        print(param)
                
        // Fetch suggested users
        showSuggestionUsers.showSuggestionUsers(parameters: param)
        
        showSuggestionUsers.onnShowSuggestionUsersLoaded = { [weak self] success in
            print("API Response: \(String(describing: self?.showSuggestionUsers.showSuggestionUsers))")
            self?.suggestionTableView.reloadData()
        }
        
    }
    
    private func setup(){
        suggestionCollectionView.delegate = self
        suggestionCollectionView.dataSource = self
        suggestionCollectionView.register(UINib(nibName: "SuggestionCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SuggestionCollectionCell")
        
        suggestionTableView.delegate = self
        suggestionTableView.dataSource = self
        suggestionTableView.register(UINib(nibName: "UserSuggestionTableCell", bundle: nil), forCellReuseIdentifier: "UserSuggestionTableCell")
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
    }
    
    @IBOutlet weak var suggestionSearchBarTapped: UISearchBar!
    
}


extension SuggestionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,  UITableViewDelegate, UITableViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestionArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCollectionCell", for: indexPath) as! SuggestionCollectionCell
        cell.lblSuggestion.text = suggestionArr[indexPath.row]
        cell.selectedView.isHidden = indexPath != selectedIndexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3.5, height: 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        collectionView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showSuggestionUsers.showSuggestedUsers?.msg?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserSuggestionTableCell", for: indexPath) as! UserSuggestionTableCell
        let showSuggestionUsersArr = showSuggestionUsers.showSuggestedUsers?.msg?[indexPath.row]
        
        cell.profileImage.sd_setImage(with: URL(string: showSuggestionUsersArr?.user.profilePic ?? ""), placeholderImage:  UIImage(named: "userProfile"), context: nil)
        cell.lblUsername.text = showSuggestionUsersArr?.user.username
        let fullName = (showSuggestionUsersArr?.user.firstName ?? "") + " " + (showSuggestionUsersArr?.user.lastName ?? "")
        cell.lblDescription.text = "Follow you \(fullName)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

