//
//  SettingAndPrivacyViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/02/2025.
//

import UIKit

class SettingAndPrivacyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var settingArr = [["img": "user", "lbl": "Mangae account"], ["img": "lock", "lbl": "Privacy"], ["img": "shield", "lbl": "Security and login"], ["img": "wallet", "lbl": "Balance"], ["img": "scan", "lbl": "QR code"], ["img": "share 1", "lbl": "Share profile"], ["img": "notificationts", "lbl": "Push notification"], ["img": "videos", "lbl": "LIVE Events"], ["img": "language", "lbl": "App language"], ["img": "moon", "lbl": "Dark mode"], ["img": "mute", "lbl": "Content preferences"], ["img": "magicStar", "lbl": "Ads"]]

    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var settingTblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear

        settingTblView.delegate = self
        settingTblView.dataSource = self
        settingTblView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingTableViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell") as! SettingTableViewCell
        cell.settingImages.image = UIImage(named: settingArr[indexPath.row]["img"] ?? "")
        cell.settingLbl.text = settingArr[indexPath.row]["lbl"]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
