//
//  SearchBarViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 25/03/2025.
//

import UIKit

class SearchBarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
   
    
    var suggestionLblArr = [["isSelected": "true", "lbl": "Top"], ["isSelected": "false", "lbl": "Videos"], ["isSelected": "false", "lbl": "Users"],["isSelected":"false", "lbl" :"Sounds"],["isSelected":"false", "lbl" :"Photos"],["isSelected":"false", "lbl" :"Place"],["isSelected":"false", "lbl" :"Hashtags"],]
    
    var userDetailsArr = [["Img":"userProfile", "lblName":"Naveed","lblUsername":"Naveed@","lblFollowers":"21 followers"],["Img":"userProfile", "lblName":"Naveed","lblUsername":"Naveed@","lblFollowers":"21 followers"],["Img":"userProfile", "lblName":"Naveed","lblUsername":"Naveed@","lblFollowers":"21 followers"],["Img":"userProfile", "lblName":"Naveed","lblUsername":"Naveed@","lblFollowers":"21 followers"],]
    
    @IBOutlet var searchBar: UITextField!
    @IBOutlet var suggestionCollectionView: UICollectionView!
    
    @IBOutlet weak var mainTblView: UITableView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.layer.backgroundColor = UIColor(named: "lightGrey")?.cgColor
        searchBar.layer.cornerRadius = 10
        searchBar.clipsToBounds = true
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: searchBar.frame.height))
        searchBar.leftView = paddingView
        searchBar.leftViewMode = .always

        if let placeholderText = searchBar.placeholder {
            searchBar.attributedPlaceholder = NSAttributedString(
                string: placeholderText,
                attributes: [
                    .foregroundColor: UIColor.darkGray,
                    .font: UIFont.systemFont(ofSize: 14)
                ]
            )
        }
        
        suggestionCollectionView.delegate = self
        suggestionCollectionView.dataSource = self
        suggestionCollectionView.register(UINib(nibName: "SuggestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SuggestionCollectionViewCell")
        
        mainTblView.delegate = self
        mainTblView.dataSource = self
        mainTblView.register(UINib(nibName: "MainTblViewCell", bundle: nil), forCellReuseIdentifier: "MainTblViewCell")
        


    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestionLblArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCollectionViewCell", for: indexPath) as! SuggestionCollectionViewCell
        cell.lblSuggestions.text = suggestionLblArr[indexPath.row]["lbl"]
        
        if suggestionLblArr[indexPath.row]["isSelected"] == "true" {
            cell.selectedView.isHidden = false
            cell.lblSuggestions.textColor = .black
        } else {
            cell.selectedView.isHidden = true
            cell.lblSuggestions.textColor = .grey
        }
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 6, height: 50)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < suggestionLblArr.count else { return }
      
        for i in 0 ..< suggestionLblArr.count {
            suggestionLblArr[i]["isSelected"] = "false"
        }
        
        suggestionLblArr[indexPath.row]["isSelected"] = "true"
   
        collectionView.reloadData()
    }
    
    
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
 


    @IBAction func backBtnPressed(_ sender: UIButton) {}
    
    @IBAction func seacrhBtnPressed(_ sender: UIButton) {}
}
