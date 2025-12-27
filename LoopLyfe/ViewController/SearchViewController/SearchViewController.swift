//
//  SearchViewController.swift
//  LoopLyfe
//
//  Created by iMac on 19/12/2025.
//

import UIKit

class SearchViewController: UIViewController {
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchDataTblView: UITableView!
  
    private var viewModel = DiscoveryViewModel()
  
    var discoverStartingPoint = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.discoverSectionDelegate = self
        viewModel.discoverSections(userID: UserDefaultsManager.shared.userId.toInt() ?? 0, startingPoint: discoverStartingPoint)
    }
    
// MARK: - Setup
    func setup(){
        searchDataTblView.delegate = self
        searchDataTblView.dataSource = self
        searchDataTblView.rowHeight = 180
        searchDataTblView.register(UINib(nibName: "SearchTblViewCell", bundle: nil), forCellReuseIdentifier: "SearchTblViewCell")
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Table View Setup
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.discoverySections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTblViewCell", for: indexPath) as! SearchTblViewCell
        let data = viewModel.discoverySections[indexPath.row]
        cell.lblTitle.text = data.hashtag?.name ?? "Unknown"
        let posts = data.hashtag?.videosCount ?? 0
        cell.lblPosts.text = "\(posts) posts"
        // Pass videos to the cell
        cell.videos = data.hashtag?.videos ?? []
        return cell
    }
}


// MARK: - Discover Delegate
extension SearchViewController: DiscoverSectionUpdater {
    func didUpdateDiscoverSection() {
        DispatchQueue.main.async {
            self.searchDataTblView.reloadData()
            self.viewModel.flagVariabe(apiCall: false) 
        }
    }
    
    func didFailDiscoverSection(error: Error) {
        DispatchQueue.main.async {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Pagination
extension SearchViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView != searchDataTblView {
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
        guard !viewModel.getApiCall() else { return }

        self.viewModel.flagVariabe(apiCall: true)
        
        discoverStartingPoint += 1
        viewModel.discoverSections(userID: UserDefaultsManager.shared.userId.toInt() ?? 0, startingPoint: discoverStartingPoint)

    }
}

