//
//  SearchDataViewController.swift
//  LoopLyfe
//
//  Created by iMac on 10/12/2025.
//

import UIKit
import SDWebImage
class SearchDataViewController: UIViewController{
   
    private var suggestionArr = ["Users", "Videos", "Sounds", "Hashtags"]
    private var selectedIndex = 0
    
    @IBOutlet weak var suggestionCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchDataTblView: UITableView!
    @IBOutlet weak var searchDataCollectionView: UICollectionView!
    @IBOutlet weak var lblDataNotFound: UILabel!
    
    var viewModel = SearchViewModel()
   
    var userStartingPoint = 0
    var videoStartingPoint = 0
    var soundStartingPoint = 0
    var hashtagStartingPoint = 0

    var selectedType = "user"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTableView()
        lblDataNotFound.isHidden = true
        searchBar.delegate = self
        searchBar.returnKeyType = .search
        
        viewModel.searchDelegate = self
        viewModel.videosDelegate = self
        viewModel.soundDelegate = self
        viewModel.hashtagsDelegate = self
    }
    
    func setupCollectionView(){
        suggestionCollectionView.delegate = self
        suggestionCollectionView.dataSource = self
        suggestionCollectionView.register(UINib(nibName: "SuggestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SuggestionCollectionViewCell")
        searchDataCollectionView.delegate = self
        searchDataCollectionView.dataSource = self
        searchDataCollectionView.register(UINib(nibName: "VideosCollectionView", bundle: nil), forCellWithReuseIdentifier: "VideosCollectionView")
    }
    
    func setupTableView(){
        searchDataTblView.delegate = self
        searchDataTblView.dataSource = self
        searchDataTblView.rowHeight = 58
        searchDataTblView.register(UINib(nibName: "SearchDataTblViewCell", bundle: nil), forCellReuseIdentifier: "SearchDataTblViewCell")
        searchDataTblView.register(UINib(nibName: "SoundsTblViewCell", bundle: nil), forCellReuseIdentifier: "SoundsTblViewCell")
        searchDataTblView.register(UINib(nibName: "HashtagsTblViewCell", bundle: nil), forCellReuseIdentifier: "HashtagsTblViewCell")
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated:true)
    }
}

// MARK: - Collection View Setup
extension SearchDataViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == suggestionCollectionView {
            return suggestionArr.count
        } else {
            return viewModel.searchVideos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == suggestionCollectionView  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCollectionViewCell", for: indexPath) as! SuggestionCollectionViewCell
            cell.lblSuggestions.text = suggestionArr[indexPath.row]
            cell.selectedView.isHidden = (indexPath.row != selectedIndex)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionView", for: indexPath) as! VideosCollectionView
            let video = viewModel.searchVideos[indexPath.row].video.thum ?? ""
            cell.videosImageView.sd_setImage(with: URL(string: video), placeholderImage: UIImage(named: "placeholder"))
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == suggestionCollectionView  {
            return CGSize(width: collectionView.frame.width / 4, height: 50)
        } else {
            let itemsPerRow: CGFloat = 3
            let spacing: CGFloat = 5
            let sectionInset: CGFloat = 0
            
            let totalSpacing = (itemsPerRow - 1) * spacing + (sectionInset * 2)
            let itemWidth = (collectionView.frame.width - totalSpacing) / itemsPerRow
            
            return CGSize(width: itemWidth, height: 150)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == suggestionCollectionView {
            
            selectedIndex = indexPath.row
            
            if indexPath.row == 0 {
                selectedType = "user"
                searchDataTblView.isHidden = false
                searchDataCollectionView.isHidden = true
                if viewModel.getApiCall() {
                    lblDataNotFound.isHidden = !viewModel.searchUser.isEmpty
                }
            }
            else if indexPath.row == 1 {
                selectedType = "video"
                searchDataTblView.isHidden = true
                searchDataCollectionView.isHidden = false
                if viewModel.getApiCall() {
                    lblDataNotFound.isHidden = !viewModel.searchVideos.isEmpty
                }
                
            }
            else if indexPath.row == 2 {
                selectedType = "sound"
                searchDataTblView.isHidden = false
                searchDataCollectionView.isHidden = true
                if viewModel.getApiCall() {
                    lblDataNotFound.isHidden = !viewModel.searchSound.isEmpty
                }
            }
            else {
                selectedType = "hashtag"
                searchDataTblView.isHidden = false
                searchDataCollectionView.isHidden = true
                if viewModel.getApiCall() {
                    lblDataNotFound.isHidden = !viewModel.searchHashtags.isEmpty
                }
            }
            
            print("Selected Index:", selectedIndex)
            print("Selected Type:", selectedType)
           
            collectionView.reloadData()
            searchDataTblView.reloadData()
            searchDataCollectionView.reloadData()
        }
    }
}

// MARK: - Table View Setup
extension SearchDataViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedIndex {
        case 0: return viewModel.searchUser.count
        case 1: return 0
        case 2: return viewModel.searchSound.count
        default: return viewModel.searchHashtags.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch selectedIndex {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchDataTblViewCell", for: indexPath) as! SearchDataTblViewCell
            let data = viewModel.searchUser[indexPath.row]
            if let imageName = data.user.profilePic, !imageName.isEmpty, let image = UIImage(named: imageName) {
                cell.profileImage.image = image
            } else {
                cell.profileImage.image = UIImage(named: "placeholder")
            }
            
            cell.lblName.text = data.user.username
            cell.lblDescription.text = data.user.bio
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SoundsTblViewCell", for: indexPath) as! SoundsTblViewCell
            let data = viewModel.searchSound[indexPath.row]
            cell.soundImage.image = UIImage(named: data.sound?.thum ?? "" ) ?? UIImage(named: "placeholder")
            cell.lblName.text = data.sound?.name
            cell.lblDescription.text = data.sound?.description
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HashtagsTblViewCell", for: indexPath) as! HashtagsTblViewCell
            let data = viewModel.searchHashtags[indexPath.row]
            cell.lblHashtags.text = data.hashtag?.name
            cell.lblDescription.text = data.hashtag?.name?.description
            return cell
        }
    }
}

// MARK: - Delegate View Setup
extension SearchDataViewController : SearchUserUpdater, SearchVideoUpdater, SearchSoundUpdater, SearchHashtagsUpdater {
    func didUpdateSearchUser() {
        DispatchQueue.main.async {
            self.searchDataTblView.reloadData()
            self.lblDataNotFound.isHidden = !self.viewModel.searchUser.isEmpty
            self.viewModel.flagVariabe(apiCall: false)
        }
    }
    
    func didFailUpdateSearchUser(error: Error) {
        DispatchQueue.main.async {
            Utility.shared.showToast(message: error.localizedDescription)
        }
    }
    
    func didUpdateVideo() {
        DispatchQueue.main.async {
            self.searchDataCollectionView.reloadData()
            self.lblDataNotFound.isHidden = !self.viewModel.searchVideos.isEmpty
            self.viewModel.flagVariabe(apiCall: false)
        }
    }
    
    func didFailVideo(error: Error) {
        DispatchQueue.main.async {
            Utility.shared.showToast(message: error.localizedDescription)
        }
    }
    
    func didUpdateSound() {
        DispatchQueue.main.async {
            self.searchDataTblView.reloadData()
            self.lblDataNotFound.isHidden = !self.viewModel.searchSound.isEmpty
            self.viewModel.flagVariabe(apiCall: false)
        }
    }
    
    func didFailUpdateSound(error: Error) {
        DispatchQueue.main.async {
            Utility.shared.showToast(message: error.localizedDescription)
        }
    }
    
    func didUpdateHashtags() {
        DispatchQueue.main.async {
            self.searchDataTblView.reloadData()
            self.lblDataNotFound.isHidden = !self.viewModel.searchHashtags.isEmpty
            self.viewModel.flagVariabe(apiCall: false)
        }
    }
    
    func didFailHashtags(error: Error) {
        DispatchQueue.main.async {
            Utility.shared.showToast(message: error.localizedDescription)
          
        }
    }
}

// MARK: - Search Delegate Setup
extension SearchDataViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let keyword = searchBar.text, !keyword.isEmpty else {
            Utility.shared.showToast(message: "Please write something")
            return
        }

        self.lblDataNotFound.isHidden = true
        self.viewModel.flagVariabe(apiCall: true)
        
        viewModel.searchUser(userId: UserDefaultsManager.shared.userId, type: "user", keyword: keyword, stratingPoint: "\(userStartingPoint)")
        viewModel.searchVideos(userId: UserDefaultsManager.shared.userId, type: "video", keyword: keyword, stratingPoint: "\(videoStartingPoint)")
        viewModel.searchSound(userId: UserDefaultsManager.shared.userId, type: "sound", keyword: keyword, stratingPoint: "\(soundStartingPoint)")
        viewModel.searchHashtags(userId: UserDefaultsManager.shared.userId, type: "hashtag", keyword: keyword, stratingPoint: "\(hashtagStartingPoint)")
       
    }
}

// MARK: - Pagination
extension SearchDataViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView != searchDataTblView && scrollView != searchDataCollectionView {
            return
        }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight - 100 {
            loadMoreData()
        }
    }
    
    private func loadMoreData() {
        guard !viewModel.getApiCall(), let keyword = searchBar.text, !keyword.isEmpty else { return }
        
        self.viewModel.flagVariabe(apiCall: true)
        
        switch selectedType {
        case "user":
            userStartingPoint += 1
            viewModel.searchUser(userId: UserDefaultsManager.shared.userId, type: "user", keyword: keyword, stratingPoint: "\(userStartingPoint)")
            
        case "video":
            videoStartingPoint += 1
            viewModel.searchVideos(userId: UserDefaultsManager.shared.userId, type: "video", keyword: keyword, stratingPoint: "\(videoStartingPoint)")
            
        case "sound":
            soundStartingPoint += 1
            viewModel.searchSound(userId: UserDefaultsManager.shared.userId, type: "sound", keyword: keyword, stratingPoint: "\(soundStartingPoint)")
            
        default:
            hashtagStartingPoint += 1
            viewModel.searchHashtags(userId: UserDefaultsManager.shared.userId, type: "hashtag", keyword: keyword, stratingPoint: "\(hashtagStartingPoint)")
        }
    }
}

