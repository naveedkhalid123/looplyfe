//
//  ContentLanguagesViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 21/02/2025.
//

import UIKit

class ContentLanguagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var languageArr = [["languages": "Bahasa Indonesia", "image": "", "isSelected": "false"], ["languages": "Bosanski", "image": "", "isSelected": "false"], ["languages": "Dansk", "image": "", "isSelected": "false"], ["languages": "Deutsch", "image": "", "isSelected": "false"], ["languages": "Dorerin Naoero", "image": "", "isSelected": "false"], ["languages": "Eesti", "image": "", "isSelected": "false"], ["languages": "English", "image": "tickCircle", "isSelected": "true"], ["languages": "Esperanto", "image": "", "isSelected": "false"], ["languages": "Francais", "image": "", "isSelected": "false"], ["languages": "Italiano", "image": "", "isSelected": "false"], ["languages": "Kurdi", "image": "", "isSelected": "false"], ["languages": "Leitiviu", "image": "", "isSelected": "false"], ["languages": "Mayanmasa", "image": "", "isSelected": "false"], ["languages": "Bahasa Indonesia", "image": "", "isSelected": "false"]]
    
    @IBOutlet var langugesTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        langugesTblView.delegate = self
        langugesTblView.dataSource = self
        langugesTblView.register(UINib(nibName: "LangugesTblViewCell", bundle: nil), forCellReuseIdentifier: "LangugesTblViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LangugesTblViewCell", for: indexPath) as! LangugesTblViewCell
        cell.langugesLbl.text = languageArr[indexPath.row]["languages"]
        
        if languageArr[indexPath.row]["isSelected"] == "true" {
            cell.selectimage.isHidden = false
        } else {
            cell.selectimage.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0 ..< languageArr.count {
            languageArr[i]["isSelected"] = "false"
        }
        languageArr[indexPath.row]["isSelected"] = "true"
        langugesTblView.reloadData()
    }
}
