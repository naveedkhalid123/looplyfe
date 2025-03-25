//
//  ProfileViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 17/02/2025.
//

import UIKit

import SDWebImage

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // make a variable and store the value of view model in the variable
    var showUserDetails = ShowUserDetailViewModel()
    var showVideosAgainstUser: ShowVideosAgainstUserIDModel?
    
    var profileArr = [["isSelected": "true", "img": "ideas"], ["isSelected": "false", "img": "heartCircle"], ["isSelected": "false", "img": "profileLock"]]
    
    var videosImagesArr = ["QRCode", "QRCode", "QRCode", "QRCode", "QRCode", "QRCode", "QRCode", "QRCode", "QRCode"]

    // MVVM Implementation
    @IBOutlet var ImageUserProfile: UIImageView!
    @IBOutlet var lblUsername: UILabel!
    @IBOutlet var followingCount: UILabel!
    @IBOutlet var followersCount: UILabel!
    @IBOutlet var likesCount: UILabel!
    
    @IBOutlet var editProfileBt: UIButton!
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var profileCollectionView: UICollectionView!
    
    @IBOutlet var videosCollectionView: UICollectionView!
    
    // collection view height code
    @IBOutlet var videosCollectionViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUserDetails()
        ImageUserProfile.layer.cornerRadius = 55
        
        editProfileBt.layer.borderWidth = 1
        editProfileBt.layer.borderColor = UIColor(named: "lightGrey")?.cgColor
        
        saveBtn.layer.borderWidth = 1
        saveBtn.layer.borderColor = UIColor(named: "lightGrey")?.cgColor
        
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        
        videosCollectionView.delegate = self
        videosCollectionView.dataSource = self
        videosCollectionView.register(UINib(nibName: "VideosCollectionView", bundle: nil), forCellWithReuseIdentifier: "VideosCollectionView")
                
//        // For showVideosAgainstUserID api
//        let param: [String: Any] = [
//            "starting_point": 0
//        ]
//        
//        showUserDetails.showVideosAgainstUser(parameters: param)
//        showUserDetails.onShowVideosAgainstUserLoaded = { [weak self] _ in
//            print("API Response: \(String(describing: self?.showUserDetails.showVideosAgainstUser))")
//            self?.showVideosAgainstUser = self?.showUserDetails.showVideosAgainstUser
//            print(self?.showVideosAgainstUser?.msg?.msgPublic.count)
//            
//            DispatchQueue.main.async {
//                self?.videosCollectionView.reloadData()
//            }
//        }
        
        

        // 2nd For showVideosAgainstUserID api
//        let param: [String: Any] = [
//            "starting_point": 0
//        ]
//        
//        showUserDetails.showUserLikedVideos(parameters: param)
//        showUserDetails.onShowUserLikedVideosLoaded = { [weak self] success in
//            print("API Response: \(String(describing: self?.showUserDetails.showUserLikedVideos))")
//            self?.videosCollectionView.reloadData()
//        }
        
        
        // 3rd For showShowUserRepostedVideos api

        let param: [String: Any] = [
            "starting_point": 0
        ]
        
        showUserDetails.showShowUserRepostedVideos(parameters: param)
        showUserDetails.showShowUserRepostedLoaded = { [weak self] success in
            print("API Response: \(String(describing: self?.showUserDetails.showShowUserRepostedVideos))")
            self?.videosCollectionView.reloadData()
        }
        
        
        
        
        
        // for making the collection view and table view collection view height dynamic, give the height to the collection view and tbl view and then make the constraints of their height and then write the below function code in view did load
        //self.updateCollectionViewHeight()
    }

    // collection view height code
    func updateCollectionViewHeight() {
        let contentSize = videosCollectionView.collectionViewLayout.collectionViewContentSize.height
        print("contentSize", contentSize)
           
        videosCollectionViewHeight.constant = contentSize
        view.layoutIfNeeded()
        videosCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == profileCollectionView {
            return profileArr.count
        } else {
            //return showUserDetails.showVideosAgainstUser?.msg?.msgPublic.count ?? 0
            //return showUserDetails.showUserLikedVideos?.msg?.count ?? 0
            return showUserDetails.showShowUserRepostedVideos?.msg?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == profileCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
            cell.profileImages.image = UIImage(named: profileArr[indexPath.row]["img"] ?? "")
            
            if profileArr[indexPath.row]["isSelected"] == "true" {
                cell.selectedView.isHidden = false
                cell.profileImages.tintColor = .black
            } else {
                cell.selectedView.isHidden = true
                cell.profileImages.tintColor = .darkTxtGrey
            }
            return cell
            
        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionView", for: indexPath) as! VideosCollectionView
//            let showVideosArr = showVideosAgainstUser?.msg?.msgPublic[indexPath.row]
//            cell.videosImageView.sd_setImage(with: URL(string: showVideosArr?.video.gif ?? ""), placeholderImage: nil, context: nil)
//            return cell
            
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionView", for: indexPath) as! VideosCollectionView
//            let showVideosArr = showUserDetails.showUserLikedVideos?.msg?[indexPath.row]
//            cell.videosImageView.sd_setImage(with: URL(string: showVideosArr?.video.thum ?? ""), placeholderImage: nil, context: nil)
//            return cell
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionView", for: indexPath) as! VideosCollectionView
            let showVideosArr = showUserDetails.showShowUserRepostedVideos?.msg?[indexPath.row]
            cell.videosImageView.sd_setImage(with: URL(string: showVideosArr?.video.thum ?? ""), placeholderImage: nil, context: nil)
            return cell

        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        for i in 0 ..< profileArr.count {
//            profileArr[i]["isSelected"] = "false"
//        }
//
//        profileArr[indexPath.row]["isSelected"] = "true"
//        
//        collectionView.reloadData()
//    }
//    
    
    // Dictionary to track selected index for videosCollectionView
    var selectedVideoIndex: IndexPath?

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == profileCollectionView {
            guard indexPath.row < profileArr.count else { return }
            for i in 0 ..< profileArr.count {
                profileArr[i]["isSelected"] = "false"
            }

            profileArr[indexPath.row]["isSelected"] = "true"

        } else if collectionView == videosCollectionView {
            guard let numberOfItems = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: indexPath.section),
                  indexPath.row < numberOfItems else {
                print("⚠️ Error: Index out of range in videosCollectionView - indexPath: \(indexPath.row), total: \(collectionView.numberOfItems(inSection: indexPath.section))")
                return
            }

            if selectedVideoIndex == indexPath {
                selectedVideoIndex = nil
            } else {
                selectedVideoIndex = indexPath
            }
        }

        collectionView.reloadData()
    }



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == profileCollectionView {
            return CGSize(width: collectionView.frame.width / 3, height: 40)
        } else {
            return CGSize(width: (collectionView.frame.width / 3) - 10, height: 150)
        }
    }
    
    @IBAction func followingBtnPressed(_ sender: UIButton) {}
    
    @IBAction func followersBtnPressed(_ sender: UIButton) {}
    
    @IBAction func likesBtnPressed(_ sender: UIButton) {}
    
    private func fetchUserDetails() {
        showUserDetails.fetchProfileUserDetails { [weak self] userDetails in
            guard let self = self, let userDetails = userDetails else { return }

            DispatchQueue.main.async {
                self.lblUsername.text = userDetails.msg?.user.username ?? "N/A"
                self.followingCount.text = "\(userDetails.msg?.user.followingCount ?? 0)"
                self.followersCount.text = "\(userDetails.msg?.user.followersCount ?? 0)"
                self.likesCount.text = "\(userDetails.msg?.user.likesCount ?? 0)"
                
                // Load image using SDWebImage
                if let imageUrl = URL(string: userDetails.msg?.user.profilePic ?? "") {
                    self.ImageUserProfile.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
                }
                
                self.ImageUserProfile.layer.cornerRadius = self.ImageUserProfile.frame.height / 2
                self.ImageUserProfile.clipsToBounds = true
                self.ImageUserProfile.layer.borderWidth = 2
                self.ImageUserProfile.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
}
