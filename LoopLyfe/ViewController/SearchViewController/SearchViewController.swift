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
    
    private var videosArr = [["lblTitle": "Concert", "lblDescription": "Trending hashtags", "lblPost": "1 post"],["lblTitle": "Concert", "lblDescription": "Trending hashtags", "lblPost": "1 post"],
                          ["lblTitle": "Concert", "lblDescription": "Trending hashtags", "lblPost": "1 post"],]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchDataTblView.delegate = self
        searchDataTblView.dataSource = self
        searchDataTblView.rowHeight = 180
        searchDataTblView.register(UINib(nibName: "SearchTblViewCell", bundle: nil), forCellReuseIdentifier: "SearchTblViewCell")

    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
    }
    
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTblViewCell", for: indexPath) as! SearchTblViewCell
        cell.lblTitle.text = videosArr[indexPath.row]["lblTitle"]
        cell.lblDescription.text = videosArr[indexPath.row]["lblDescription"]
        cell.lblPosts.text = videosArr[indexPath.row]["lblPost"]
        return cell
    }
    
}
