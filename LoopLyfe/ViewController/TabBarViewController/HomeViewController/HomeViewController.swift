//
//  HomeViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 17/02/2025.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var homeTblViewArr: [[String: String]] = [
        ["likeCount": "1.2M", "commentCount": "223k", "userName": "@naveed", "postDesc": "This is actually the place to visit", "hastag": "#googleearth #googlemaps"],
        ["likeCount": "1.2M", "commentCount": "223k", "userName": "@naveed", "postDesc": "This is actually the place to visit", "hastag": "#googleearth #googlemaps"]
    ]
    
    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(UINib(nibName: "HomeTabelViewCell", bundle: nil), forCellReuseIdentifier: "HomeTabelViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeTblViewArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTabelViewCell", for: indexPath) as! HomeTabelViewCell
        let postData = homeTblViewArr[indexPath.row]
        cell.likeCount.text = postData["likeCount"]
        cell.commentCountLbl.text = postData["commentCount"]
        cell.userNameLbl.text = postData["userName"]
        cell.postCaptionLbl.text = postData["postDesc"]
        cell.postHashTagsLbl.text = postData["hastag"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height
    }

}
