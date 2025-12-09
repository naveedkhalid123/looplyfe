////
////  SearchBarViewController.swift
////  LoopLyfe
////
////  Created by Naveed Khalid on 25/03/2025.
////
//
//import UIKit
//
//import SDWebImage
//
//class SearchBarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
//    
//    
//    // Call the view model in a variable
//    private var showSearchBar = ShowUserDetailViewModel()
//
//    var suggestionLblArr = [["isSelected": "true", "lbl": "Top"], ["isSelected": "false", "lbl": "Videos"], ["isSelected": "false", "lbl": "Users"], ["isSelected": "false", "lbl": "Sounds"], ["isSelected": "false", "lbl": "Photos"], ["isSelected": "false", "lbl": "Place"], ["isSelected": "false", "lbl": "Hashtags"]]
//
//    var userDetailsArr = [["Img": "userProfile", "lblName": "Naveed", "lblUsername": "Naveed@", "lblFollowers": "21 followers"], ["Img": "userProfile", "lblName": "Naveed", "lblUsername": "Naveed@", "lblFollowers": "21 followers"], ["Img": "userProfile", "lblName": "Naveed", "lblUsername": "Naveed@", "lblFollowers": "21 followers"], ["Img": "userProfile", "lblName": "Naveed", "lblUsername": "Naveed@", "lblFollowers": "21 followers"]]
//
//
//    @IBOutlet var searchBar: UISearchBar!
//    @IBOutlet var suggestionCollectionView: UICollectionView!
//    @IBOutlet var scrollView: UIScrollView!
//    @IBOutlet var mainTblView: UITableView!
//    @IBOutlet var mainCollectionView: UICollectionView!
//    @IBOutlet var videosCollectionViewHeight: NSLayoutConstraint!
//    @IBOutlet var containerView: UIView!
//    @IBOutlet var tableViewHeight: NSLayoutConstraint!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        searchBar.delegate = self
//
//        suggestionCollectionView.delegate = self
//        suggestionCollectionView.dataSource = self
//        suggestionCollectionView.register(UINib(nibName: "SuggestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SuggestionCollectionViewCell")
//
//        mainTblView.delegate = self
//        mainTblView.dataSource = self
//        mainTblView.register(UINib(nibName: "MainTblViewCell", bundle: nil), forCellReuseIdentifier: "MainTblViewCell")
//
//        tableViewHeight.constant = CGFloat(userDetailsArr.count * 70)
//
//        mainCollectionView.delegate = self
//        mainCollectionView.dataSource = self
//        mainCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
//        
//        
//        
//        
//        //showSearchBarData.. User
//                let param: [String: Any] = [
//                    "user_id": "",
//                    "type": "user",
//                    "keyword": "wasiq",
//                    "starting_point": 0
//                ]
//                
//        showSearchBar.showSearchBarData(parameters: param)
//        
//        showSearchBar.onShowSearchBarLoaded = { [weak self] success in
//            print("API Response: \(String(describing: self?.showSearchBar.showSearchBarData))")
//            self?.mainTblView.reloadData()
//        }
//        
//        
//        
//        //showSearchSound..
////                let param: [String: Any] = [
////                    "user_id": "",
////                     "type": "sound",
////                     "keyword": "_",
////                     "starting_point": 0
////                ]
////                
////        showSearchBar.showSearchSound(parameters: param)
////        
////        showSearchBar.onShowSearchSoundModelLoaded = { [weak self] success in
////            print("API Response: \(String(describing: self?.showSearchBar.showSearchSound))")
////            self?.mainTblView.reloadData()
////        }
////        
//        
//        
//        //showSearchHastags..
////        let param: [String: Any] = [
////            "user_id": "",
////             "type": "hashtag",
////             "keyword": "_",
////             "starting_point": 0
////        ]
////        
////        showSearchBar.showSearchHashtags(parameters: param)
////        
////        showSearchBar.onnShowSearchHastagsLoaded = { [weak self] success in
////            print("API Response: \(String(describing: self?.showSearchBar.showSearchHashtags))")
////            self?.mainTblView.reloadData()
////        }
//        
//        
//        
////
////        //showSearchBarData.. Videos
////        let param: [String: Any] = [
////              "user_id": "",
////              "type": "video",
////              "keyword": "_",
////              "starting_point": 0
////        ]
////        
////        showSearchBar.showSearchVideos(parameters: param)
////        
////        showSearchBar.onnShowSearchVideosLoaded = { [weak self] success in
////            print("API Response: \(String(describing: self?.showSearchBar.showSearchVideos))")
////            self?.mainCollectionView.reloadData()
////        }
//    
//    }
//
//    func updateContainerHeight() {
//        DispatchQueue.main.async {
//            self.mainCollectionView.layoutIfNeeded()
//            let contentSize = self.mainCollectionView.collectionViewLayout.collectionViewContentSize.height
//            print("contentSize:", contentSize)
//
//            self.videosCollectionViewHeight.constant = contentSize
//            self.view.layoutIfNeeded()
//
//            self.mainCollectionView.reloadData()
//        }
//    }
//
//    // MARK: - UICollectionView DataSource & Delegate
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//         if collectionView == suggestionCollectionView {
//           return suggestionLblArr.count
//        } else {
//            // Vidoes API Integeration
//            return showSearchBar.showSearchVideos?.msg?.count ?? 0
//        
//        }
//          
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == suggestionCollectionView {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCollectionViewCell", for: indexPath) as! SuggestionCollectionViewCell
//            cell.lblSuggestions.text = suggestionLblArr[indexPath.row]["lbl"]
//
//            if suggestionLblArr[indexPath.row]["isSelected"] == "true" {
//                cell.selectedView.isHidden = false
//                cell.lblSuggestions.textColor = .black
//            } else {
//                cell.selectedView.isHidden = true
//                cell.lblSuggestions.textColor = .gray
//            }
//            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
//            let showVideosArr = showSearchBar.showSearchVideos?.msg?[indexPath.row]
//            cell.videosImageView.sd_setImage(with: URL(string: showVideosArr?.video.gif ?? ""), placeholderImage: nil, context: nil)
//            cell.lblHashtags.text = showVideosArr?.video.description
//            cell.userProfile.sd_setImage(with: URL(string: showVideosArr?.user.profilePic ?? "userProfile"),placeholderImage: nil, context: nil)
//            cell.lblUsername.text = showVideosArr?.user.username
//            cell.lblLikesCount.text = "\(showVideosArr?.video.likeCount ?? 0)"
//    
//            return cell
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return collectionView == suggestionCollectionView ? CGSize(width: collectionView.frame.width / 6, height: 50) : CGSize(width: (collectionView.frame.width / 2) - 4, height: 350)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard indexPath.row < suggestionLblArr.count else { return }
//
//        for i in 0 ..< suggestionLblArr.count {
//            suggestionLblArr[i]["isSelected"] = "false"
//        }
//        suggestionLblArr[indexPath.row]["isSelected"] = "true"
//        collectionView.reloadData()
//    }
//
//    // MARK: - UITableView DataSource & Delegate
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       // return userDetailsArr.count
//        
//        // For user API
//        return showSearchBar.showSearchBarData?.msg.count ?? 0
//        
//        // For Sound API
//        //return showSearchBar.showSearchSound?.msg?.count ?? 0
//        
//        // For Hastags API
//       // return showSearchBar.showSearchHashtags?.msg?.count ?? 0
//        
//        
//        
//      
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTblViewCell", for: indexPath) as! MainTblViewCell
//        
//        // For user API
//        let showUsersArr = showSearchBar.showSearchBarData?.msg[indexPath.row]
//        cell.ImgUsrProfile.sd_setImage(with: URL(string: showUsersArr?.user.profilePic ?? ""), placeholderImage: nil, context: nil)
//        cell.lblName.text = showUsersArr?.user.username
//        cell.lblUserName.text = showUsersArr?.user.firstName
//        cell.lblFollowers.text = "\(showUsersArr?.user.followersCount ?? 0)"
//        
//        // For Sound API
////        let showUsersArr = showSearchBar.showSearchSound?.msg?[indexPath.row]
////        cell.ImgUsrProfile.sd_setImage(with: URL(string: showUsersArr?.sound.thum ?? ""), placeholderImage: nil, context: nil)
////        cell.lblName.text = showUsersArr?.sound.name
////        cell.lblUserName.text = showUsersArr?.sound.created
////        cell.lblFollowers.text = showUsersArr?.sound.duration
////        
//        
//        // For Hastags API
//        
////        let showUsersArr =  showSearchBar.showSearchHashtags?.msg?[indexPath.row]
////       
////        cell.lblName.text = showUsersArr?.hashtag.name
////        cell.lblUserName.text = showUsersArr?.hashtag.views
////        cell.lblFollowers.text = "\(showUsersArr?.hashtag.videosCount ?? 0)"
//        
//        
//        
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
//
//    // MARK: - UISearchBar Delegate
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
//        print("User searched for: \(searchText)")
//
//        let param: [String: Any] = [
//            "user_id": "",
//            "type": "user",
//            "keyword": "wasiq",
//            "starting_point": 0
//        ]
//
//        // Call the API method from SearchBarModel
//        showSearchBar.showSearchBarData(parameters: param)
//
//        // Observe the response from API
//        showSearchBar.onShowSearchBarLoaded = { isLoaded in
//            if isLoaded {
//                if let searchData = self.showSearchBar.showSearchBarData?.msg {
//                    print("Search Data:", searchData)
//                } else {
//                    print("No search results found.")
//                }
//            } else {
//                print("Error fetching search results.")
//            }
//        }
//
//        // Dismiss the keyboard
//        searchBar.resignFirstResponder()
//    }
//
//    @IBAction func backBtnPressed(_ sender: UIButton) {}
//}
