//
//  SettingAndPrivacyViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/02/2025.
//

import UIKit

class SettingAndPrivacyViewController: UIViewController {
    var settingArr = [["img": "user", "lbl": "Mangae account"], ["img": "lock", "lbl": "Privacy"], ["img": "shield", "lbl": "Security and login"], ["img": "wallet", "lbl": "Balance"], ["img": "scan", "lbl": "QR code"], ["img": "share 1", "lbl": "Share profile"], ["img": "notificationts", "lbl": "Push notification"], ["img": "videos", "lbl": "LIVE Events"], ["img": "language", "lbl": "App language"], ["img": "moon", "lbl": "Dark mode"], ["img": "mute", "lbl": "Content preferences"], ["img": "magicStar", "lbl": "Ads"]]

    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var settingTblView: UITableView!
    
    var userDetails: ShowUserDetailMsg?

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
        setupCollectionView()
    }

    // MARK: - Functions
    func navBarSetup(){
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
    }
    
    func setupCollectionView(){
        settingTblView.delegate = self
        settingTblView.dataSource = self
        settingTblView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingTableViewCell")
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Setup Table View
extension SettingAndPrivacyViewController :  UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       //  tableView.deselectRow(at: indexPath, animated: true)
        print("Index", indexPath.row)
        if indexPath.row == 0 {
            let settingsVC = ManageAccountViewController(nibName: "ManageAccountViewController", bundle: nil)
            navigationController?.pushViewController(settingsVC, animated: true)
        }
        
        if indexPath.row == 1 {
            let settingsVC = PrivacyViewController(nibName: "PrivacyViewController", bundle: nil)
            navigationController?.pushViewController(settingsVC, animated: true)
        }
        
        if indexPath.row == 2 {
            let settingVC = SearchDataViewController(nibName: "SearchDataViewController", bundle: nil)
            navigationController?.pushViewController(settingVC, animated: true
            )
        }
        
        if indexPath.row == 3 {
            let settingVC = WalletViewController(nibName: "WalletViewController", bundle: nil)
            navigationController?.pushViewController(settingVC, animated: true
            )
        }
        
        if indexPath.row == 4 {
            let settingVC = SearchViewController(nibName: "SearchViewController", bundle: nil)
            navigationController?.pushViewController(settingVC, animated: true
            )
        }
        
        if indexPath.row == 5 {
            shareApp()
        }
        
        if indexPath.row == 8 {
            let settingsVC = ContentLanguagesViewController(nibName: "ContentLanguagesViewController", bundle: nil)
            navigationController?.pushViewController(settingsVC, animated: true)
        }
        
        if indexPath.row == 11 {
            let settingsVC = CreatorsToolViewController(nibName: "CreatorsToolViewController", bundle: nil)
            navigationController?.pushViewController(settingsVC, animated: true)
        }
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
    
    func shareApp() {
        let name = userDetails?.user?.firstName ?? ""
        
        let text = "Check out this app!\nUsername: \(name)"
        
        let vc = UIActivityViewController(
            activityItems: [text],
            applicationActivities: nil
        )
        
        present(vc, animated: true)
    }

}
