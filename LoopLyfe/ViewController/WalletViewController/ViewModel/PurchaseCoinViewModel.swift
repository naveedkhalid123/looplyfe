//
//  PurchaseCoinViewModel.swift
//  LoopLyfe
//
//  Created by iMac on 09/12/2025.
//

import Foundation

protocol PurchaseCoinUpdater : AnyObject {
    func didUpdatePurchaseCoins(_ purchaseCoins: PurchaseCoinMsg)
    func didFailUpdatePurchaseCoins(error: Error)
}

final class PurchaseCoinViewModel {
    
    weak var purchaseCoinsDelegate: PurchaseCoinUpdater?
    private var apiManager = APIManager()
    
    func purchaseCoins(userId: String, coin: String, title: String, price: String, transactionId: String, device: String) {
        let params: [String: Any] = [
            "user_id": userId,
            "coin": coin,
            "title": title,
            "price": price,
            "transaction_id": transactionId,
            "device": device
        ]

        apiManager.purchaseCoin(parameters: params) { result in
            switch result {
            case .success(let response):
                print("Purchase Successful:", response)
                
                if let purchaseMsg = response.msg {
                    self.purchaseCoinsDelegate?.didUpdatePurchaseCoins(purchaseMsg)
                }

            case .failure(let error):
                print("Purchase Failed:", error.localizedDescription)
                self.purchaseCoinsDelegate?.didFailUpdatePurchaseCoins(error: error)
            }
        }
    }

}


