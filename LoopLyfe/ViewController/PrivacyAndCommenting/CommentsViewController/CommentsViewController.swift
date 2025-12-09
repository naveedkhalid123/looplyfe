//
//  CommentsViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 25/02/2025.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var commentsArr = [["head": "Everyone", "desc": ""], ["head": "Friends", "desc": "Followers that you follow back"], ["head": "No one", "desc": ""]]
    
    var commonFiltersArr = [["head": "Filter comments", "desc": "Recent comments on your videos will be hidden uless you approve rthem."], ["head": "Filter spam and ofensive comments", "desc": "Recent comments that may be offensive or spam will be hide unless you approve them."], ["head": "Filter Keywords", "desc": "Recent comments on your videos will be hidden uless you approve rthem."]]

    @IBOutlet var commentsTblView: UITableView!
    @IBOutlet var commonFiltersTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsTblView.delegate = self
        commentsTblView.dataSource = self
        commentsTblView.register(UINib(nibName: "CommentsTblViewCell", bundle: nil), forCellReuseIdentifier: "CommentsTblViewCell")
        
        commonFiltersTblView.delegate = self
        commonFiltersTblView.dataSource = self
        commonFiltersTblView.register(UINib(nibName: "FiltersTblViewCell", bundle: nil), forCellReuseIdentifier: "FiltersTblViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == commentsTblView {
            return commentsArr.count
        } else {
            return commonFiltersArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == commentsTblView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTblViewCell", for: indexPath) as! CommentsTblViewCell
            cell.commentsHeadLbl.text = commentsArr[indexPath.row]["head"]
            cell.commentsDesc.text = commentsArr[indexPath.row]["desc"]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FiltersTblViewCell", for: indexPath) as! FiltersTblViewCell
            cell.filterHeadLbl.text = commonFiltersArr[indexPath.row]["head"]
            cell.filterDesc.text = commonFiltersArr[indexPath.row]["desc"]
    
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == commentsTblView {
            return 84
        } else {
            return 80
        }
    }
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
