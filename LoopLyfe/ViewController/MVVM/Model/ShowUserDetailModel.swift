//
//  showUserDetail.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 11/03/2025.
//

import Foundation

// MARK: - ShowUserDetail

struct ShowUserDetailModel: Codable {
    let code: Int
    var msg: Msg?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case code, msg, message
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        if code == 200 {
            msg = try container.decodeIfPresent(Msg.self, forKey: .msg)
            message = nil
        } else {
            msg = nil
            message = try container.decodeIfPresent(String.self, forKey: .message)
        }
    }
}

// MARK: - Msg

struct Msg: Codable {
    let user: User
    let pushNotification: PushNotification
    let privacySetting: PrivacySetting

    enum CodingKeys: String, CodingKey {
        case user = "User"
        case pushNotification = "PushNotification"
        case privacySetting = "PrivacySetting"
    }
}

// MARK: - PrivacySetting

struct PrivacySetting: Codable {
    let id, videosDownload: Int
    let directMessage, duet, likedVideos, videoComment: String

    enum CodingKeys: String, CodingKey {
        case id
        case videosDownload = "videos_download"
        case directMessage = "direct_message"
        case duet
        case likedVideos = "liked_videos"
        case videoComment = "video_comment"
    }
}

// MARK: - PushNotification

struct PushNotification: Codable {
    let id, likes, comments, newFollowers: Int
    let mentions, directMessages, videoUpdates: Int

    enum CodingKeys: String, CodingKey {
        case id, likes, comments
        case newFollowers = "new_followers"
        case mentions
        case directMessages = "direct_messages"
        case videoUpdates = "video_updates"
    }
}

// MARK: - User

struct User: Codable {
    let id: Int
    let firstName, lastName, gender, bio: String
    let website, dob, socialID, email: String
    let phone, password: String
    let profilePic: String
    let profilePicSmall, profileGIF, profileVideo, role: String
    let username, social, deviceToken, token: String
    let active: Int
    let lat, long: String
    let online, verified: Int
    let authToken, version, device, ip: String
    let city, country, state, region: String
    let locationString: String
    let countryID: Int
    let wallet, paypal: String
    let userPrivate, profileView: Int
    let resetWalletDatetime, referralCode, registerWith, stripeCustomerID: String
    let created: String
    let parent, business: Int
    let story: [String]
    let comissionEarned, totalBalanceUsd, totalAllTimeCoins: Int
    let interests: [InterestElement]
    let followersCount, followingCount, likesCount, videoCount: Int
    let profileVisitCount, soldItemsCount, taggedProductsCount: Int
    let playlist: [Playlist]
    let shop, unreadNotification: Int

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
        case userPrivate = "private"
        case profileView = "profile_view"
        case resetWalletDatetime = "reset_wallet_datetime"
        case referralCode = "referral_code"
        case registerWith = "register_with"
        case stripeCustomerID = "stripe_customer_id"
        case created, parent, business, story
        case comissionEarned = "comission_earned"
        case totalBalanceUsd = "total_balance_usd"
        case totalAllTimeCoins = "total_all_time_coins"
        case interests = "Interests"
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case likesCount = "likes_count"
        case videoCount = "video_count"
        case profileVisitCount = "profile_visit_count"
        case soldItemsCount = "sold_items_count"
        case taggedProductsCount = "tagged_products_count"
        case playlist = "Playlist"
        case shop
        case unreadNotification = "unread_notification"
    }
}

// MARK: - InterestElement

struct InterestElement: Codable {
    let userInterest: UserInterest
    let interest: InterestInterest

    enum CodingKeys: String, CodingKey {
        case userInterest = "UserInterest"
        case interest = "Interest"
    }
}

// MARK: - InterestInterest

struct InterestInterest: Codable {
    let id, interestSectionID: Int
    let title: String
    let order: Int
    let created: String

    enum CodingKeys: String, CodingKey {
        case id
        case interestSectionID = "interest_section_id"
        case title, order, created
    }
}

// MARK: - UserInterest

struct UserInterest: Codable {
    let id, userID: Int
    let interestID: Int?
    let created: String
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case interestID = "interest_id"
        case created, name
    }
}

// MARK: - Playlist

struct Playlist: Codable {
    let playlist: UserInterest

    enum CodingKeys: String, CodingKey {
        case playlist = "Playlist"
    }
}
