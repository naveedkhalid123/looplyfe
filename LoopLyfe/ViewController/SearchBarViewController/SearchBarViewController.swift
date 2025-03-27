//
//  SearchBarViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 25/03/2025.
//

import UIKit

class SearchBarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var suggestionLblArr = [["isSelected": "true", "lbl": "Top"], ["isSelected": "false", "lbl": "Videos"], ["isSelected": "false", "lbl": "Users"],["isSelected":"false", "lbl" :"Sounds"],["isSelected":"false", "lbl" :"Photos"],["isSelected":"false", "lbl" :"Place"],["isSelected":"false", "lbl" :"Hashtags"],]
    
    var userDetailsArr = [["Img":"userProfile", "lblName":"Naveed","lblUsername":"Naveed@","lblFollowers":"21 followers"],["Img":"userProfile", "lblName":"Naveed","lblUsername":"Naveed@","lblFollowers":"21 followers"],["Img":"userProfile", "lblName":"Naveed","lblUsername":"Naveed@","lblFollowers":"21 followers"],["Img":"userProfile", "lblName":"Naveed","lblUsername":"Naveed@","lblFollowers":"21 followers"],]
    
    var userVideosArr = [["Img":"Upload", "lblTage":"#CapCut","lblProfile":"userProfile","lblName":"Naveed","lblLikes":"43"],["Img":"Upload", "lblTage":"#CapCut","lblProfile":"userProfile","lblName":"Naveed","lblLikes":"43"],["Img":"Upload", "lblTage":"#CapCut","lblProfile":"userProfile","lblName":"Naveed","lblLikes":"43"],["Img":"Upload", "lblTage":"#CapCut","lblProfile":"userProfile","lblName":"Naveed","lblLikes":"43"],["Img":"Upload", "lblTage":"#CapCut","lblProfile":"userProfile","lblName":"Naveed","lblLikes":"43"],["Img":"Upload", "lblTage":"#CapCut","lblProfile":"userProfile","lblName":"Naveed","lblLikes":"43"],]
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var suggestionCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainTblView: UITableView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var videosCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self  // Setting search bar delegate
        
        suggestionCollectionView.delegate = self
        suggestionCollectionView.dataSource = self
        suggestionCollectionView.register(UINib(nibName: "SuggestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SuggestionCollectionViewCell")
        
        mainTblView.delegate = self
        mainTblView.dataSource = self
        mainTblView.register(UINib(nibName: "MainTblViewCell", bundle: nil), forCellReuseIdentifier: "MainTblViewCell")
        
        tableViewHeight.constant = CGFloat(userDetailsArr.count * 70)
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
    }
    
    func updateContainerHeight() {
        DispatchQueue.main.async {
            self.mainCollectionView.layoutIfNeeded()
            let contentSize = self.mainCollectionView.collectionViewLayout.collectionViewContentSize.height
            print("contentSize:", contentSize)
            
            self.videosCollectionViewHeight.constant = contentSize
            self.view.layoutIfNeeded()
            
            self.mainCollectionView.reloadData()
        }
    }
    
    // MARK: - UICollectionView DataSource & Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == suggestionCollectionView ? suggestionLblArr.count : userVideosArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == suggestionCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCollectionViewCell", for: indexPath) as! SuggestionCollectionViewCell
            cell.lblSuggestions.text = suggestionLblArr[indexPath.row]["lbl"]
            
            if suggestionLblArr[indexPath.row]["isSelected"] == "true" {
                cell.selectedView.isHidden = false
                cell.lblSuggestions.textColor = .black
            } else {
                cell.selectedView.isHidden = true
                cell.lblSuggestions.textColor = .gray
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
            cell.userProfile.image = UIImage(named: userVideosArr[indexPath.row]["Img"] ?? "")
            cell.lblHashtags.text = userVideosArr[indexPath.row]["lblTage"]
            cell.userProfile.image = UIImage(named: userVideosArr[indexPath.row]["lblProfile"] ?? "")
            cell.lblUsername.text = userVideosArr[indexPath.row]["lblName"]
            cell.lblLikesCount.text = userVideosArr[indexPath.row]["lblLikes"]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView == suggestionCollectionView ? CGSize(width: collectionView.frame.width / 6, height: 50) : CGSize(width: (collectionView.frame.width / 2) - 4, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < suggestionLblArr.count else { return }
        
        for i in 0 ..< suggestionLblArr.count {
            suggestionLblArr[i]["isSelected"] = "false"
        }
        suggestionLblArr[indexPath.row]["isSelected"] = "true"
        collectionView.reloadData()
    }
    
    // MARK: - UITableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetailsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTblViewCell", for: indexPath) as! MainTblViewCell
        cell.ImgUsrProfile.image = UIImage(named: userDetailsArr[indexPath.row]["Img"] ?? "")
        cell.lblName.text = userDetailsArr[indexPath.row]["lblName"]
        cell.lblUserName.text = userDetailsArr[indexPath.row]["lblUsername"]
        cell.lblFollowers.text = userDetailsArr[indexPath.row]["lblFollowers"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // MARK: - UISearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        print("User searched for: \(searchText)")
        
        // Dismiss the keyboard
        searchBar.resignFirstResponder()
        
        // You can use searchText to filter your data and reload table/collection view
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {}
    
}
