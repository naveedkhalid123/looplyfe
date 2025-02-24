//
//  TimeLimitViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/02/2025.
//

import UIKit

class TimeLimitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var timeLimitArr = [["timeLbl": "40 minutes", "circleImg": "tickCircle", "isSelected": "true"], ["timeLbl": "60 minutes", "circleImg": "", "isSelected": "false"], ["timeLbl": "90 minutes", "circleImg": "", "isSelected": "false"], ["timeLbl": "120 minutes", "circleImg": "", "isSelected": "false"]]

    @IBOutlet var timeLineTblView: UITableView!
    @IBOutlet var navigationBar: UINavigationBar!
    
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
        
        if timeLimitArr[indexPath.row]["isSelected"] == "true" {
            cell.timeCircleImg.image = UIImage(named: "tickCircle")
            cell.timeCircleImg.isHidden = false
        } else {
            cell.timeCircleImg.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0 ..< timeLimitArr.count {
            timeLimitArr[i]["isSelected"] = "false"
        }
        timeLimitArr[indexPath.row]["isSelected"] = "true"
        
        timeLineTblView.reloadData()
    }
}
