//
//  CreatorsToolViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 24/02/2025.
//

import UIKit

class CreatorsToolViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var creatorsToolsArr = [["Image":"analytics","toolName":"Analytics"],["Image":"creators","toolName":"Creator Portal"],["Image":"fire","toolName":"Promote"],["Image":"askQuestion","toolName":"Q&A"],]

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        toolsTableView.delegate = self
        toolsTableView.dataSource = self
        toolsTableView.register(UINib(nibName: "ToolsTableViewCell", bundle: nil), forCellReuseIdentifier: "ToolsTableViewCell")

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creatorsToolsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToolsTableViewCell", for: indexPath) as! ToolsTableViewCell
        cell.toolsImage.image = UIImage(named: creatorsToolsArr[indexPath.row]["Image"] ?? "")
        cell.toolsLbl.text = creatorsToolsArr[indexPath.row]["toolName"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
