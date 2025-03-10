//
//  ProfileViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 17/02/2025.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var profileArr = [["isSelected":"true","img" :"ideas"],["isSelected": "false", "img": "heartCircle"],["isSelected": "false","img" : "profileLock"]]
    
    
  
    
    @IBOutlet weak var editProfileBt: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editProfileBt.layer.borderWidth = 1
        editProfileBt.layer.borderColor = UIColor(named: "lightGrey")?.cgColor
        
        saveBtn.layer.borderWidth = 1
        saveBtn.layer.borderColor = UIColor(named: "lightGrey")?.cgColor
        
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        cell.profileImages.image = UIImage(named: profileArr[indexPath.row]["img"] ?? "")
        
        if profileArr[indexPath.row]["isSelected"] == "true" {
            cell.selectedView.isHidden = false
        }else {
            cell.selectedView.isHidden = true
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<profileArr.count {
            profileArr[i]["isSelected"] = "false"
        }

        profileArr[indexPath.row]["isSelected"] = "true"
        
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3 , height: 40)
    }

}
