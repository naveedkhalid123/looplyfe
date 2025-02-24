//
//  ChooseAudienceViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 24/02/2025.
//

import UIKit

class ChooseAudienceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var chooseAudienceArr = ["Automatic (LoopLyfe chooses for you)", "Custom"]

    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var audienceTableViewCell: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear

        audienceTableViewCell.delegate = self
        audienceTableViewCell.dataSource = self
        audienceTableViewCell.register(UINib(nibName: "ChooseAudienceTblViewCell", bundle: nil), forCellReuseIdentifier: "ChooseAudienceTblViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chooseAudienceArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseAudienceTblViewCell") as! ChooseAudienceTblViewCell
        cell.chooseAudienceLbl.text = chooseAudienceArr[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
