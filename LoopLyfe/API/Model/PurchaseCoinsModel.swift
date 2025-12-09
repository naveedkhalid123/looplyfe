// MARK: - PurchaseCoinModel
struct PurchaseCoinModel: Codable {
    let code: Int
    var msg: PurchaseCoinMsg?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case code, msg
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)

        if code == 200 {
            msg = try container.decodeIfPresent(PurchaseCoinMsg.self, forKey: .msg)
            message = nil
        } else {
            msg = nil
            message = try container.decodeIfPresent(String.self, forKey: .msg)
        }
    }
}

// MARK: - PurchaseCoinMsg
struct PurchaseCoinMsg: Codable {
    let purchaseCoin: PurchaseCoin?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case purchaseCoin = "PurchaseCoin"
        case user = "User"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        purchaseCoin = try container.decodeIfPresent(PurchaseCoin.self, forKey: .purchaseCoin)
        user = try container.decodeIfPresent(User.self, forKey: .user)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(purchaseCoin, forKey: .purchaseCoin)
        try container.encodeIfPresent(user, forKey: .user)
    }
}

// MARK: - PurchaseCoin
struct PurchaseCoin: Codable {
    let id: Int?
    let userID: Int?
    let title: String?
    let coin: Int?
    let price: Double?
    let transactionID: String?
    let device: String?
    let cardID: Int?
    let created: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title
        case coin
        case price
        case transactionID = "transaction_id"
        case device
        case cardID = "card_id"
        case created
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(Int.self, forKey: .id)
        userID = try container.decodeIfPresent(Int.self, forKey: .userID)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        coin = try container.decodeIfPresent(Int.self, forKey: .coin)
        price = try container.decodeIfPresent(Double.self, forKey: .price)
        transactionID = try container.decodeIfPresent(String.self, forKey: .transactionID)
        device = try container.decodeIfPresent(String.self, forKey: .device)
        cardID = try container.decodeIfPresent(Int.self, forKey: .cardID)
        created = try container.decodeIfPresent(String.self, forKey: .created)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(userID, forKey: .userID)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(coin, forKey: .coin)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(transactionID, forKey: .transactionID)
        try container.encodeIfPresent(device, forKey: .device)
        try container.encodeIfPresent(cardID, forKey: .cardID)
        try container.encodeIfPresent(created, forKey: .created)
    }
}
