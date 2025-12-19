//
//  ProfileViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 17/02/2025.
//

import UIKit
import SDWebImage
import SkeletonView

class ProfileViewController: UIViewController {
   
    var showUserDetails = ShowUserDetailViewModel()
    var viewModel = ProfileViewModel()    
    var userDetails: ShowUserDetailMsg?
    
    // Dictionary to track selected index for videosCollectionView
    var selectedVideoIndex: IndexPath?
    
    var userVideos: [Private] = []
    var userPrivateVideos: [Private] = []
    var index = 0
    var userLikeVideos: [Private] = []

    var profileArr = [["isSelected": "true", "img": "ideas"], ["isSelected": "false", "img": "heartCircle"], ["isSelected": "false", "img": "profileLock"]]
    
    var videosImagesArr = ["QRCode", "QRCode", "QRCode", "QRCode", "QRCode", "QRCode", "QRCode", "QRCode", "QRCode"]

    // MVVM Implementation
    @IBOutlet var ImageUserProfile: UIImageView!
    @IBOutlet var lblUsername: UILabel!
    @IBOutlet var followingCount: UILabel!
    @IBOutlet var followersCount: UILabel!
    @IBOutlet var likesCount: UILabel!
    
    @IBOutlet weak var bioBtn: UIButton!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet var editProfileBt: UIButton!
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var profileCollectionView: UICollectionView!
    
    @IBOutlet var videosCollectionView: UICollectionView!
    
    // collection view height code
    @IBOutlet var videosCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var shareVideoDescription: UILabel!
    @IBOutlet weak var shareVideoDesciptionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        collectionViewSetUp()
                
        viewModel.delegate = self
        viewModel.videoDelegate = self
        viewModel.likeVideosDelegate = self
        
        viewModel.fetchUserDetails()
        profileView.showAnimatedGradientSkeleton()
        videosCollectionView.showAnimatedSkeleton()
        
        viewModel.showVideosAgainstUserID(userID: UserDefaultsManager.shared.userId.toInt() ?? 0, startingPoint: 0 )
        print("User ID", UserDefaultsManager.shared.userId)
        viewModel.showUserLikeVideos(userID: UserDefaultsManager.shared.userId.toInt() ?? 0, startingPoint:0 )
    }

    func setUpUI(){
        ImageUserProfile.layer.cornerRadius = 55
        editProfileBt.layer.borderWidth = 1
        editProfileBt.layer.borderColor = UIColor(named: "lightGrey")?.cgColor
        saveBtn.layer.borderWidth = 1
        saveBtn.layer.borderColor = UIColor(named: "lightGrey")?.cgColor
    }
    
    func collectionViewSetUp(){
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        
        videosCollectionView.delegate = self
        videosCollectionView.dataSource = self
        videosCollectionView.register(UINib(nibName: "VideosCollectionView", bundle: nil), forCellWithReuseIdentifier: "VideosCollectionView")
    }
    
    @IBAction func menuBtnTapped(_ sender: Any) {
        let vc = SettingAndPrivacyViewController(nibName: "SettingAndPrivacyViewController", bundle: nil)
        vc.userDetails = userDetails
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func followingBtnPressed(_ sender: UIButton) {}
    
    @IBAction func followersBtnPressed(_ sender: UIButton) {}
    
    @IBAction func likesBtnPressed(_ sender: UIButton) {}
}


// MARK: - Collection View Setup
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "VideosCollectionView"
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == profileCollectionView {
            return profileArr.count
        } else {
            switch index {
            case 0 :
                return userVideos.count
            case 1 :
                return userLikeVideos.count
            default:
                return userPrivateVideos.count
            }
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionView", for: indexPath) as! VideosCollectionView
            switch index {
            case 0 :
                let showVideosArr = userVideos[indexPath.row].video
                cell.videosImageView.sd_setImage(with: URL(string: showVideosArr?.gif ?? ""), placeholderImage: nil, context: nil)
            case 1 :
                let showVideosArr = userLikeVideos[indexPath.row].video
                cell.videosImageView.sd_setImage(with: URL(string: showVideosArr?.gif ?? ""), placeholderImage: nil, context: nil)
            default:
                let showVideosArr = userPrivateVideos[indexPath.row].video
                cell.videosImageView.sd_setImage(with: URL(string: showVideosArr?.gif ?? ""), placeholderImage: nil, context: nil)
            }
            return cell
        }
    }
    
    func selectIndex(indexNumber: Int){
        switch profileArr.count {
        case 0:
            index = indexNumber
            self.videosCollectionView.reloadData()
            // Update collection view height after reloading
            self.videosCollectionView.layoutIfNeeded()
            self.updateCollectionViewHeight()
        case 1:
            index = indexNumber
            self.videosCollectionView.reloadData()
            self.videosCollectionView.layoutIfNeeded()
            self.updateCollectionViewHeight()
        default:
            index = indexNumber
            self.videosCollectionView.reloadData()
            // Update collection view height after reloading
            self.videosCollectionView.layoutIfNeeded()
            self.updateCollectionViewHeight()
        }
    }
     
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == profileCollectionView {
            guard indexPath.row < profileArr.count else { return }
            for i in 0 ..< profileArr.count {
                profileArr[i]["isSelected"] = "false"
            }
            profileArr[indexPath.row]["isSelected"] = "true"
            selectIndex(indexNumber: indexPath.row)
            
        } else if collectionView == videosCollectionView {
            guard let numberOfItems = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: indexPath.section),
                  indexPath.row < numberOfItems else {
                print(" Error: Index out of range in videosCollectionView - indexPath: \(indexPath.row), total: \(collectionView.numberOfItems(inSection: indexPath.section))")
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
            return CGSize(width: (collectionView.frame.width / 3) - 10, height: 200)
        }
    }
}

// MARK: - DELEGATES
extension ProfileViewController :  ShowUserDetailsUpdater, ShowUserVideosUpdater, ShowLikeVideosUpdater {
    
    func didUpdateUserProfile(_ userProfile: ShowUserDetailMsg) {
        DispatchQueue.main.async {
            print("UserProfile", userProfile)
            self.userDetails = userProfile
            self.fetchDetails(userProfile)
            // Stop skeleton
            self.profileView.hideSkeleton()
        }
    }
    
    func didFailUpdateUserProfile(error: Error) {
        DispatchQueue.main.async {
            print("error",error.localizedDescription)
        }
    }
    
    func fetchDetails(_ userProfile: ShowUserDetailMsg){
        if let urlString = userProfile.user?.profilePic,
           let url = URL(string: urlString) {
            ImageUserProfile.sd_setImage(with: url)
        } else {
            ImageUserProfile.image = UIImage(named: "placeholder")
        }

        followersCount.text = userProfile.user?.followersCount?.toString()
        followingCount.text = userProfile.user?.followingCount?.toString()
        likesCount.text = userProfile.user?.likesCount?.toString()
        lblUsername.text = userProfile.user?.username
        bioBtn.setTitle(userProfile.user?.bio ?? "", for: .normal)
    }
    
    func didUpdateUserVideo(_ userVideo: VideoMsg) {
        DispatchQueue.main.async {
            if let videos = userVideo.msgPublic, !videos.isEmpty {
                self.userPrivateVideos = userVideo.msgPrivate ?? []
                self.userVideos = videos
                self.shareVideoDesciptionView.isHidden = true
                self.videosCollectionView.hideSkeleton()
                self.videosCollectionView.reloadData()
                // Update collection view height after reloading
                self.videosCollectionView.layoutIfNeeded()
                self.updateCollectionViewHeight()
            } else {
                self.userVideos = []
                self.shareVideoDesciptionView.isHidden = false
            }
        }
    }

    func updateCollectionViewHeight() {
        guard let layout = videosCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        var numberOfItems = 0
        switch index {
        case 0:
            numberOfItems = userVideos.count
        case 1:
            numberOfItems = userLikeVideos.count
        default:
            numberOfItems = userPrivateVideos.count
        }
        let itemsPerRow: CGFloat = 2
        let spacing = layout.minimumInteritemSpacing
        let lineSpacing = layout.minimumLineSpacing
        let totalSpacing = (itemsPerRow - 1) * spacing

        let itemWidth = (videosCollectionView.frame.width - totalSpacing) / itemsPerRow
        let itemHeight: CGFloat = 200

        let numberOfRows = ceil(CGFloat(numberOfItems) / itemsPerRow)
        let totalHeight = (numberOfRows * itemHeight) + ((numberOfRows - 1) * lineSpacing) + 50

        videosCollectionViewHeight.constant = totalHeight
        view.layoutIfNeeded()
    }
    
    func didFailUpdateUserVideo(error: Error) {
        DispatchQueue.main.async {
            print("error",error.localizedDescription)
        }
    }
    
    func didUpdateUserLikeVideo(likeVideo: [Private]) {
        self.userLikeVideos = likeVideo
        print("User liked videos count:", userLikeVideos.count)
    }

    func didFailUserLikeVideo(error: Error) {
        DispatchQueue.main.async {
            print("error", error.localizedDescription)
        }
    }
}
