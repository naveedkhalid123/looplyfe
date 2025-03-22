////
////  ShowAllNotificationsModel.swift
////  LoopLyfe
////
////  Created by Naveed Khalid on 21/03/2025.
////


import Foundation

// MARK: - ShowAllNotificationsModel
struct ShowAllNotificationsModel: Codable {
    let code: Int
    let msg: [ShowAllNotificationsMsg]?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case code, msg
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)

        if let msgArray = try? container.decode([ShowAllNotificationsMsg].self, forKey: .msg) {
            msg = msgArray
            message = nil
        } else if let msgString = try? container.decode(String.self, forKey: .msg) {
            msg = nil
            message = msgString
        } else {
            msg = nil
            message = nil
        }
    }
}

// MARK: - Msg
struct ShowAllNotificationsMsg: Codable {
    let notification: Notification
    let video: ShowAllNotificationsVideo
    let sender, receiver: Receiver
    let order: Order

    enum CodingKeys: String, CodingKey {
        case notification = "Notification"
        case video = "Video"
        case sender = "Sender"
        case receiver = "Receiver"
        case order = "Order"
    }
}

// MARK: - Notification
struct Notification: Codable {
    let id, senderID, receiverID: Int
    let string, type: String
    let videoID, liveStreamingID, roomID: Int
    let status: String
    let read: Int
    let created: String
    let orderID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case senderID = "sender_id"
        case receiverID = "receiver_id"
        case string, type
        case videoID = "video_id"
        case liveStreamingID = "live_streaming_id"
        case roomID = "room_id"
        case status, read, created
        case orderID = "order_id"
    }
}

// MARK: - Order
struct Order: Codable {
    let id, productID, productTitle, productDescription: String?
    let productPrice, cardID, userID, deliveryAddressID: String?
    let transactionID, note, total, status: String?
    let device, created: String?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case productTitle = "product_title"
        case productDescription = "product_description"
        case productPrice = "product_price"
        case cardID = "card_id"
        case userID = "user_id"
        case deliveryAddressID = "delivery_address_id"
        case transactionID = "transaction_id"
        case note, total, status, device, created
    }
}

// MARK: - Receiver
struct Receiver: Codable {
    let id: Int
    let firstName, lastName, gender, bio: String
    let website, dob, socialID, email: String
    let phone: String?
    let password: String
    let profilePic: String
    let profilePicSmall, profileGIF, profileVideo, role: String
    let username, social, deviceToken, token: String
    let active: Int
    let lat, long: String
    let online, verified: Int
    let authToken, version, device, ip: String
    let city, country, state, region: String
    let locationString: String
    let countryID, wallet: Int
    let paypal: String
    let receiverPrivate, profileView: Int
    let resetWalletDatetime, referralCode, registerWith, stripeCustomerID: String
    let created: String
    let parent, business: Int
    let button: String?
    let block: Int?
    let story: [String]?
    let followersCount, followingCount, likesCount, videoCount: Int?
    let shop, soldItemsCount, taggedProductsCount: Int?
    let playlist: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case gender, bio, website, dob
        case socialID = "social_id"
        case email, phone, password
        case profilePic = "profile_pic"
        case profilePicSmall = "profile_pic_small"
        case profileGIF = "profile_gif"
        case profileVideo = "profile_video"
        case role, username, social
        case deviceToken = "device_token"
        case token, active, lat, long, online, verified
        case authToken = "auth_token"
        case version, device, ip, city, country, state, region
        case locationString = "location_string"
        case countryID = "country_id"
        case wallet, paypal
        case receiverPrivate = "private"
        case profileView = "profile_view"
        case resetWalletDatetime = "reset_wallet_datetime"
        case referralCode = "referral_code"
        case registerWith = "register_with"
        case stripeCustomerID = "stripe_customer_id"
        case created, parent, business, button, block, story
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case likesCount = "likes_count"
        case videoCount = "video_count"
        case shop
        case soldItemsCount = "sold_items_count"
        case taggedProductsCount = "tagged_products_count"
        case playlist = "Playlist"
    }
}

// MARK: - Video
struct ShowAllNotificationsVideo: Codable {
    let id, userID, description, video: String?
    let thum, thumSmall, gif, view: String?
    let section, soundID, privacyType, allowComments: String?
    let allowDuet, block, duetVideoID, oldVideoID: String?
    let duration, promote, pinCommentID, pin: String?
    let repostUserID, repostVideoID, qualityCheck, viral: String?
    let story, countryID, city, state: String?
    let country, region, locationString, share: String?
    let videoWithWatermark, lat, long, productID: String?
    let locationID, width, height, userThumbnail: String?
    let defaultThumbnail, compression, nudityFound, error: String?
    let created: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case description, video, thum
        case thumSmall = "thum_small"
        case gif, view, section
        case soundID = "sound_id"
        case privacyType = "privacy_type"
        case allowComments = "allow_comments"
        case allowDuet = "allow_duet"
        case block
        case duetVideoID = "duet_video_id"
        case oldVideoID = "old_video_id"
        case duration, promote
        case pinCommentID = "pin_comment_id"
        case pin
        case repostUserID = "repost_user_id"
        case repostVideoID = "repost_video_id"
        case qualityCheck = "quality_check"
        case viral, story
        case countryID = "country_id"
        case city, state, country, region
        case locationString = "location_string"
        case share
        case videoWithWatermark = "video_with_watermark"
        case lat, long
        case productID = "product_id"
        case locationID = "location_id"
        case width, height
        case userThumbnail = "user_thumbnail"
        case defaultThumbnail = "default_thumbnail"
        case compression
        case nudityFound = "nudity_found"
        case error, created
    }
}
