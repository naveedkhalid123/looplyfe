//
//  showUserDetail.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 11/03/2025.
//

import Foundation

// MARK: - ShowUserDetailModel
struct ShowUserDetailModel: Codable {
    let code: Int
    var msg: ShowUserDetailMsg?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case code, msg
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        if code == 200 {
            msg = try container.decodeIfPresent(ShowUserDetailMsg.self, forKey: .msg)
            message = nil
        } else {
            msg = nil
            message = try container.decodeIfPresent(String.self, forKey: .msg)
        }
    }
}

// MARK: - Msg
struct ShowUserDetailMsg: Codable {
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
    let id: Int?
    let videosDownload: Int?
    let directMessage, duet, likedVideos, videoComment: String?

    enum CodingKeys: String, CodingKey {
        case id
        case videosDownload = "videos_download"
        case directMessage = "direct_message"
        case duet
        case likedVideos = "liked_videos"
        case videoComment = "video_comment"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        videosDownload = try container.decodeIfPresent(Int.self, forKey: .videosDownload)
        directMessage = try container.decodeIfPresent(String.self, forKey: .directMessage)
        duet = try container.decodeIfPresent(String.self, forKey: .duet)
        likedVideos = try container.decodeIfPresent(String.self, forKey: .likedVideos)
        videoComment = try container.decodeIfPresent(String.self, forKey: .videoComment)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(videosDownload, forKey: .videosDownload)
        try container.encodeIfPresent(directMessage, forKey: .directMessage)
        try container.encodeIfPresent(duet, forKey: .duet)
        try container.encodeIfPresent(likedVideos, forKey: .likedVideos)
        try container.encodeIfPresent(videoComment, forKey: .videoComment)
    }
}

// MARK: - PushNotification
struct PushNotification: Codable {
    let id, likes, comments, newFollowers: Int?
    let mentions, directMessages, videoUpdates: Int?

    enum CodingKeys: String, CodingKey {
        case id, likes, comments
        case newFollowers = "new_followers"
        case mentions
        case directMessages = "direct_messages"
        case videoUpdates = "video_updates"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        likes = try container.decodeIfPresent(Int.self, forKey: .likes)
        comments = try container.decodeIfPresent(Int.self, forKey: .comments)
        newFollowers = try container.decodeIfPresent(Int.self, forKey: .newFollowers)
        mentions = try container.decodeIfPresent(Int.self, forKey: .mentions)
        directMessages = try container.decodeIfPresent(Int.self, forKey: .directMessages)
        videoUpdates = try container.decodeIfPresent(Int.self, forKey: .videoUpdates)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(likes, forKey: .likes)
        try container.encodeIfPresent(comments, forKey: .comments)
        try container.encodeIfPresent(newFollowers, forKey: .newFollowers)
        try container.encodeIfPresent(mentions, forKey: .mentions)
        try container.encodeIfPresent(directMessages, forKey: .directMessages)
        try container.encodeIfPresent(videoUpdates, forKey: .videoUpdates)
    }
}

// MARK: - User
struct User: Codable {
    let id: Int
    let firstName, lastName, gender, bio: String?
    let website, dob, socialID, email: String?
    let phone, password, profilePic, profilePicSmall: String?
    let profileGIF, profileVideo, role, username: String?
    let social, deviceToken, token: String?
    let active: Int?
    let lat, long: String?
    let online, verified: Int?
    let authToken, version, device, ip: String?
    let city, country, state, region, locationString: String?
    let countryID: Int?
    let wallet: StringOrInt?
    let paypal: String?
    let userPrivate, profileView: Int?
    let resetWalletDatetime, referralCode, registerWith, stripeCustomerID: String?
    let created: String?
    let parent, business: Int?
    let comissionEarned, totalBalanceUsd, totalAllTimeCoins: Int?
    let followersCount, followingCount, likesCount, videoCount: Int?
    let profileVisitCount: Bool?
    let soldItemsCount, taggedProductsCount, shop, unreadNotification: Int?

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
        case created, parent, business
        case comissionEarned = "comission_earned"
        case totalBalanceUsd = "total_balance_usd"
        case totalAllTimeCoins = "total_all_time_coins"
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case likesCount = "likes_count"
        case videoCount = "video_count"
        case profileVisitCount = "profile_visit_count"
        case soldItemsCount = "sold_items_count"
        case taggedProductsCount = "tagged_products_count"
        case shop
        case unreadNotification = "unread_notification"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        gender = try container.decodeIfPresent(String.self, forKey: .gender)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        website = try container.decodeIfPresent(String.self, forKey: .website)
        dob = try container.decodeIfPresent(String.self, forKey: .dob)
        socialID = try container.decodeIfPresent(String.self, forKey: .socialID)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        password = try container.decodeIfPresent(String.self, forKey: .password)
        profilePic = try container.decodeIfPresent(String.self, forKey: .profilePic)
        profilePicSmall = try container.decodeIfPresent(String.self, forKey: .profilePicSmall)
        profileGIF = try container.decodeIfPresent(String.self, forKey: .profileGIF)
        profileVideo = try container.decodeIfPresent(String.self, forKey: .profileVideo)
        role = try container.decodeIfPresent(String.self, forKey: .role)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        social = try container.decodeIfPresent(String.self, forKey: .social)
        deviceToken = try container.decodeIfPresent(String.self, forKey: .deviceToken)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        active = try container.decodeIfPresent(Int.self, forKey: .active)
        lat = try container.decodeIfPresent(String.self, forKey: .lat)
        long = try container.decodeIfPresent(String.self, forKey: .long)
        online = try container.decodeIfPresent(Int.self, forKey: .online)
        verified = try container.decodeIfPresent(Int.self, forKey: .verified)
        authToken = try container.decodeIfPresent(String.self, forKey: .authToken)
        version = try container.decodeIfPresent(String.self, forKey: .version)
        device = try container.decodeIfPresent(String.self, forKey: .device)
        ip = try container.decodeIfPresent(String.self, forKey: .ip)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        state = try container.decodeIfPresent(String.self, forKey: .state)
        region = try container.decodeIfPresent(String.self, forKey: .region)
        locationString = try container.decodeIfPresent(String.self, forKey: .locationString)
        countryID = try container.decodeIfPresent(Int.self, forKey: .countryID)
        wallet = try container.decodeIfPresent(StringOrInt.self, forKey: .wallet)
        paypal = try container.decodeIfPresent(String.self, forKey: .paypal)
        userPrivate = try container.decodeIfPresent(Int.self, forKey: .userPrivate)
        profileView = try container.decodeIfPresent(Int.self, forKey: .profileView)
        resetWalletDatetime = try container.decodeIfPresent(String.self, forKey: .resetWalletDatetime)
        referralCode = try container.decodeIfPresent(String.self, forKey: .referralCode)
        registerWith = try container.decodeIfPresent(String.self, forKey: .registerWith)
        stripeCustomerID = try container.decodeIfPresent(String.self, forKey: .stripeCustomerID)
        created = try container.decodeIfPresent(String.self, forKey: .created)
        parent = try container.decodeIfPresent(Int.self, forKey: .parent)
        business = try container.decodeIfPresent(Int.self, forKey: .business)
        comissionEarned = try container.decodeIfPresent(Int.self, forKey: .comissionEarned)
        totalBalanceUsd = try container.decodeIfPresent(Int.self, forKey: .totalBalanceUsd)
        totalAllTimeCoins = try container.decodeIfPresent(Int.self, forKey: .totalAllTimeCoins)
        followersCount = try container.decodeIfPresent(Int.self, forKey: .followersCount)
        followingCount = try container.decodeIfPresent(Int.self, forKey: .followingCount)
        likesCount = try container.decodeIfPresent(Int.self, forKey: .likesCount)
        videoCount = try container.decodeIfPresent(Int.self, forKey: .videoCount)
        profileVisitCount = try container.decodeIfPresent(Bool.self, forKey: .profileVisitCount)
        soldItemsCount = try container.decodeIfPresent(Int.self, forKey: .soldItemsCount)
        taggedProductsCount = try container.decodeIfPresent(Int.self, forKey: .taggedProductsCount)
        shop = try container.decodeIfPresent(Int.self, forKey: .shop)
        unreadNotification = try container.decodeIfPresent(Int.self, forKey: .unreadNotification)
    }


    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(firstName, forKey: .firstName)
        try container.encodeIfPresent(lastName, forKey: .lastName)
        try container.encodeIfPresent(gender, forKey: .gender)
        try container.encodeIfPresent(bio, forKey: .bio)
        try container.encodeIfPresent(website, forKey: .website)
        try container.encodeIfPresent(dob, forKey: .dob)
        try container.encodeIfPresent(socialID, forKey: .socialID)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(password, forKey: .password)
        try container.encodeIfPresent(profilePic, forKey: .profilePic)
        try container.encodeIfPresent(profilePicSmall, forKey: .profilePicSmall)
        try container.encodeIfPresent(profileGIF, forKey: .profileGIF)
        try container.encodeIfPresent(profileVideo, forKey: .profileVideo)
        try container.encodeIfPresent(role, forKey: .role)
        try container.encodeIfPresent(username, forKey: .username)
        try container.encodeIfPresent(social, forKey: .social)
        try container.encodeIfPresent(deviceToken, forKey: .deviceToken)
        try container.encodeIfPresent(token, forKey: .token)
        try container.encodeIfPresent(active, forKey: .active)
        try container.encodeIfPresent(lat, forKey: .lat)
        try container.encodeIfPresent(long, forKey: .long)
        try container.encodeIfPresent(online, forKey: .online)
        try container.encodeIfPresent(verified, forKey: .verified)
        try container.encodeIfPresent(authToken, forKey: .authToken)
        try container.encodeIfPresent(version, forKey: .version)
        try container.encodeIfPresent(device, forKey: .device)
        try container.encodeIfPresent(ip, forKey: .ip)
        try container.encodeIfPresent(city, forKey: .city)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(state, forKey: .state)
        try container.encodeIfPresent(region, forKey: .region)
        try container.encodeIfPresent(locationString, forKey: .locationString)
        try container.encodeIfPresent(countryID, forKey: .countryID)
        try container.encodeIfPresent(wallet, forKey: .wallet)
        try container.encodeIfPresent(paypal, forKey: .paypal)
        try container.encodeIfPresent(userPrivate, forKey: .userPrivate)
        try container.encodeIfPresent(profileView, forKey: .profileView)
        try container.encodeIfPresent(resetWalletDatetime, forKey: .resetWalletDatetime)
        try container.encodeIfPresent(referralCode, forKey: .referralCode)
        try container.encodeIfPresent(registerWith, forKey: .registerWith)
        try container.encodeIfPresent(stripeCustomerID, forKey: .stripeCustomerID)
        try container.encodeIfPresent(created, forKey: .created)
        try container.encodeIfPresent(parent, forKey: .parent)
        try container.encodeIfPresent(business, forKey: .business)
        try container.encodeIfPresent(comissionEarned, forKey: .comissionEarned)
        try container.encodeIfPresent(totalBalanceUsd, forKey: .totalBalanceUsd)
        try container.encodeIfPresent(totalAllTimeCoins, forKey: .totalAllTimeCoins)
        try container.encodeIfPresent(followersCount, forKey: .followersCount)
        try container.encodeIfPresent(followingCount, forKey: .followingCount)
        try container.encodeIfPresent(likesCount, forKey: .likesCount)
        try container.encodeIfPresent(videoCount, forKey: .videoCount)
        try container.encodeIfPresent(profileVisitCount, forKey: .profileVisitCount)
        try container.encodeIfPresent(soldItemsCount, forKey: .soldItemsCount)
        try container.encodeIfPresent(taggedProductsCount, forKey: .taggedProductsCount)
        try container.encodeIfPresent(shop, forKey: .shop)
        try container.encodeIfPresent(unreadNotification, forKey: .unreadNotification)
    }

}

enum StringOrInt: Codable, Equatable {
  case string(String)
  case int(Int)
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let intValue = try? container.decode(Int.self) {
      self = .int(intValue)
    } else if let stringValue = try? container.decode(String.self) {
      self = .string(stringValue)
    } else {
      throw DecodingError.typeMismatch(StringOrInt.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected either Int or String"))
    }
  }
  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .string(let value):
      try container.encode(value)
    case .int(let value):
      try container.encode(value)
    }
  }
  var stringValue: String? {
    switch self {
    case .string(let value):
      return value
    case .int(let value):
      return String(value)
    }
  }
  var intValue: Int? {
    switch self {
    case .string(let value):
      return Int(value)
    case .int(let value):
      return value
    }
  }
}







