//
//  WalletViewController.swift
//  LoopLyfe
//
//  Created by iMac on 06/12/2025.
//

import UIKit
import StoreKit
import NotificationCenter
import UserNotifications

class WalletViewController: UIViewController {
      
    @IBOutlet weak var lblCoinBalance: UILabel!
    @IBOutlet weak var walletTblView: UITableView!
    
    private var products = [SKProduct]()
    
    var viewModel = PurchaseCoinViewModel()
    var purchaseCoins : PurchaseCoinMsg?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetUp()
        self.products = IAPManager.shared.products
        lblCoinBalance.text = UserDefaultsManager.shared.wallet
        
        viewModel.purchaseCoinsDelegate = self
        notificationSetUp()
    }
    
    func tableViewSetUp(){
        walletTblView.delegate = self
        walletTblView.dataSource = self
        walletTblView.register(UINib(nibName: "WalletTblViewCell", bundle: nil), forCellReuseIdentifier: "WalletTblViewCell")
    }
    
    func notificationSetUp(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleCoinPurchase(_:)),
            name: NSNotification.Name("CoinPurchased"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleCoinPurchaseFailed(_:)),
            name: NSNotification.Name("CoinPurchaseFailed"),
            object: nil
        )
    }

    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func priceButtonPressed(_ sender: UIButton){
        let product = products[sender.tag]
        IAPManager.shared.purchase(product: product)
    }
}

// MARK: - Wallet Table View
extension WalletViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletTblViewCell", for: indexPath) as! WalletTblViewCell
        let product = products[indexPath.row]
        cell.lblNumberOfCoins.text = product.localizedTitle
        cell.btnPrice.setTitle("\(product.priceLocale.currencySymbol ?? "$")\(product.price)", for: .normal)
        cell.btnPrice.tag = indexPath.row
        cell.btnPrice.addTarget(self, action: #selector(priceButtonPressed(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}

// MARK: - Notification Setup
extension WalletViewController {
    
    @objc func handleCoinPurchase(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo as? [String: String] else { return }

        let userId = UserDefaultsManager.shared.userId
        let coin = userInfo["coin"] ?? "0"
        let title = userInfo["title"] ?? ""
        let price = userInfo["price"] ?? "0"
        let transactionId = userInfo["transactionId"] ?? UUID().uuidString
        let device = userInfo["device"] ?? UIDevice.current.systemName
    
        // Call the API now that we have the values
        viewModel.purchaseCoins(userId: userId, coin: coin, title: title, price: price, transactionId: transactionId, device: device)
    }

    @objc func handleCoinPurchaseFailed(_ notification: NSNotification) {
        if let errorMessage = notification.userInfo?["error"] as? String {
            print("Purchase failed:", errorMessage)
        }
    }
}

// MARK: - Delegate Setup
extension WalletViewController : PurchaseCoinUpdater {
    func didUpdatePurchaseCoins(_ purchaseCoins: PurchaseCoinMsg) {
        self.purchaseCoins = purchaseCoins
        UserDefaultsManager.shared.wallet = purchaseCoins.user?.wallet ?? ""
        lblCoinBalance.text = UserDefaultsManager.shared.wallet
    }
    
    func didFailUpdatePurchaseCoins(error: Error) {
        DispatchQueue.main.async {
            print("error", error.localizedDescription)
        }
    }
    
}
