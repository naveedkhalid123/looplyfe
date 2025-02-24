//
//  ContentPreferncesViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 21/02/2025.
//

import UIKit

class ContentPreferncesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var langugesArr = ["English"]

    @IBOutlet var languagesTbleView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        languagesTbleView.delegate = self
        languagesTbleView.dataSource = self
        languagesTbleView.register(UINib(nibName: "LangugeTableViewCell", bundle: nil), forCellReuseIdentifier: "LangugeTableViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return langugesArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LangugeTableViewCell", for: indexPath) as! LangugeTableViewCell
        cell.languagesbl.text = langugesArr[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
