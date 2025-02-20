//
//  TimeLimitViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/02/2025.
//

import UIKit

class TimeLimitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var timeLimitArr = [["timeLbl":"40 minutes","circleImg":"tickCircle"],["timeLbl":"60 minutes","circleImg":""],["timeLbl":"90 minutes","circleImg":""],["timeLbl":"120 minutes","circleImg":""],]

    @IBOutlet weak var timeLineTblView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLineTblView.delegate = self
        timeLineTblView.dataSource = self
        timeLineTblView.register(UINib(nibName: "TimeLineTblViewCell", bundle: nil), forCellReuseIdentifier: "TimeLineTblViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeLimitArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeLineTblViewCell") as! TimeLineTblViewCell
        cell.timeLbl.text = timeLimitArr[indexPath.row]["timeLbl"]
        cell.timeCircleImg.image = UIImage(named: timeLimitArr[indexPath.row]["circleImg"] ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
