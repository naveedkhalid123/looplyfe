import Foundation
import StoreKit

final class IAPManager: NSObject {

    static let shared = IAPManager()

    var products = [SKProduct]()
    private var productBeingPurchased: SKProduct?

    enum Products: String, CaseIterable {
        case buy100Coins = "com.dinosoftlab.tiktik.buy100Coins"
        case buy500Coins = "com.dinosoftlab.tiktik.buy500Coins"
        case buy2000Coins = "com.dinosoftlab.tiktik.buy2000Coins"
        case buy5000Coins = "com.dinosoftlab.tiktik.buy5000Coins"
        case buy10000Coins = "com.dinosoftlab.tiktik.buy10000Coins"
    }

    // MARK: - Fetch Products
    public func fetchProducts() {
        let ids = Set(Products.allCases.map { $0.rawValue })
        let request = SKProductsRequest(productIdentifiers: ids)
        request.delegate = self
        request.start()
    }

    // MARK: - Purchase
    public func purchase(product: SKProduct) {
        guard SKPaymentQueue.canMakePayments() else { return }

        productBeingPurchased = product
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
    }
}

// MARK: - SKProductsRequestDelegate
extension IAPManager: SKProductsRequestDelegate {

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.products = response.products.sorted { $0.price.doubleValue < $1.price.doubleValue }
        }
    }


    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Failed to fetch products: \(error.localizedDescription)")
    }
}

// MARK: - SKPaymentTransactionObserver
extension IAPManager: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

        for transaction in transactions {

            guard transaction.payment.productIdentifier ==
                    self.productBeingPurchased?.productIdentifier else { continue }

            switch transaction.transactionState {

            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)

                let product = productBeingPurchased
                let userId = UserDefaultsManager.shared.userId
                let transactionId = transaction.transactionIdentifier ?? UUID().uuidString
                
                // Get coin amount from product ID
                let coin: String
                switch product?.productIdentifier {
                case Products.buy100Coins.rawValue:
                    coin = "100"
                case Products.buy500Coins.rawValue:
                    coin = "500"
                case Products.buy2000Coins.rawValue:
                    coin = "2000"
                case Products.buy5000Coins.rawValue:
                    coin = "5000"
                case Products.buy10000Coins.rawValue:
                    coin = "10000"
                default:
                    coin = "0"
                }

                let price = product?.price.stringValue ?? "0"
                let title = product?.localizedTitle ?? ""
                
                // Send all fields through NotificationCenter
                NotificationCenter.default.post(
                    name: NSNotification.Name("CoinPurchased"),
                    object: nil,
                    userInfo: [
                        "userId": userId,
                        "coin": coin,
                        "title": title,
                        "price": price,
                        "transactionId": transactionId
                    ]
                )

                handleCoinPurchase(id: transaction.payment.productIdentifier)


            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)

                let errorMsg = transaction.error?.localizedDescription ?? "Unknown error"

                NotificationCenter.default.post(
                    name: NSNotification.Name("CoinPurchaseFailed"),
                    object: nil,
                    userInfo: ["error": errorMsg]
                )

                print("Purchase failed:", errorMsg)

            default:
                break
            }
        }
    }

    // MARK: - Handle consumable
    private func handleCoinPurchase(id: String) {
        productBeingPurchased = nil
        print("Consumable purchased:", id)

        let coins: Int

        switch id {
        case Products.buy100Coins.rawValue:
            coins = 100
        case Products.buy500Coins.rawValue:
            coins = 500
        case Products.buy2000Coins.rawValue:
            coins = 2000
        case Products.buy5000Coins.rawValue:
            coins = 5000
        case Products.buy10000Coins.rawValue:
            coins = 10000
        default:
            coins = 0
        }

        // Add coins to UserDefaults
        let currentCoins = UserDefaults.standard.integer(forKey: "coins")
        UserDefaults.standard.set(currentCoins + coins, forKey: "coins")

        NotificationCenter.default.post(name: NSNotification.Name("coinsUpdated"), object: nil)
    }
}
