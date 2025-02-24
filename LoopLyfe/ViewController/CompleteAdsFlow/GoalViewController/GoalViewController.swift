//
//  GoalViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 24/02/2025.
//

import UIKit

class GoalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var goalsArr = [["image": "more", "head": "More engagement", "desc": "Get more views, likes and comments."], ["image": "visit", "head": "More website visits", "desc": "Guide more people to your website."], ["image": "followers", "head": "More followers", "desc": "Improve your chances to gain followers."]]
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var goalTableViewCell: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        
        goalTableViewCell.delegate = self
        goalTableViewCell.dataSource = self
        goalTableViewCell.register(UINib(nibName: "GoalTableViewCell", bundle: nil), forCellReuseIdentifier: "GoalTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalTableViewCell") as! GoalTableViewCell
        cell.goalImage.image = UIImage(named: goalsArr[indexPath.row]["image"] ?? "")
        cell.goalHead.text = goalsArr[indexPath.row]["head"]
        cell.goalSubHead.text = goalsArr[indexPath.row]["desc"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
