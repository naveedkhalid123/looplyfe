
import Foundation

// MARK: - ShowUserDetail
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
    let user: User?
    let pushNotification: PushNotification?
    let privacySetting: PrivacySetting?

    enum CodingKeys: String, CodingKey {
        case user = "User"
        case pushNotification = "PushNotification"
        case privacySetting = "PrivacySetting"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        user = try container.decodeIfPresent(User.self, forKey: .user)
        pushNotification = try container.decodeIfPresent(PushNotification.self, forKey: .pushNotification)
        privacySetting = try container.decodeIfPresent(PrivacySetting.self, forKey: .privacySetting)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(user, forKey: .user)
        try container.encodeIfPresent(pushNotification, forKey: .pushNotification)
        try container.encodeIfPresent(privacySetting, forKey: .privacySetting)
    }
}


// MARK: - PrivacySetting
struct PrivacySetting: Codable {
    let id: Int?
    let videosDownload: Int?
    let directMessage: String?
    let duet: String?
    let likedVideos: String?
    let videoComment: String?

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
    let id: Int?
    let likes: Int?
    let comments: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, likes, comments
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        likes = try container.decodeIfPresent(Int.self, forKey: .likes)
        comments = try container.decodeIfPresent(Int.self, forKey: .comments)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(likes, forKey: .likes)
        try container.encodeIfPresent(comments, forKey: .comments)
    }
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let firstName, lastName, bio: String?
    let website: String?
    let profilePic: String?
    let username: String?
    let online, verified: Int?
    let locationString: String?
    let countryID: Int?
    let wallet, paypal: String? 
    let userPrivate, profileView: Int?
    let created: String?
    let parent, business: Int?
    let story: [String]?
    let interests: [InterestElement]?
    let followersCount, followingCount, likesCount, videoCount: Int?
    let  soldItemsCount, taggedProductsCount: Int?
    let playlist: [Playlist]?
    let shop, unreadNotification: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case bio, website
        case profilePic = "profile_pic"
        case username
        case online, verified
        case locationString = "location_string"
        case countryID = "country_id"
        case wallet, paypal
        case userPrivate = "private"
        case profileView = "profile_view"
        case created, parent, business, story
        case interests = "Interests"
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case likesCount = "likes_count"
        case videoCount = "video_count"
        case soldItemsCount = "sold_items_count"
        case taggedProductsCount = "tagged_products_count"
        case playlist = "Playlist"
        case shop
        case unreadNotification = "unread_notification"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(Int.self, forKey: .id)
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        website = try container.decodeIfPresent(String.self, forKey: .website)
        profilePic = try container.decodeIfPresent(String.self, forKey: .profilePic)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        online = try container.decodeIfPresent(Int.self, forKey: .online)
        verified = try container.decodeIfPresent(Int.self, forKey: .verified)
        
        locationString = try container.decodeIfPresent(String.self, forKey: .locationString)
        countryID = try container.decodeIfPresent(Int.self, forKey: .countryID)
        wallet = try container.decodeIfPresent(String.self, forKey: .wallet)
        paypal = try container.decodeIfPresent(String.self, forKey: .paypal)
        userPrivate = try container.decodeIfPresent(Int.self, forKey: .userPrivate)
        profileView = try container.decodeIfPresent(Int.self, forKey: .profileView)
      
        created = try container.decodeIfPresent(String.self, forKey: .created)
        parent = try container.decodeIfPresent(Int.self, forKey: .parent)
        business = try container.decodeIfPresent(Int.self, forKey: .business)
        story = try container.decodeIfPresent([String].self, forKey: .story)
     
        interests = try container.decodeIfPresent([InterestElement].self, forKey: .interests)
        followersCount = try container.decodeIfPresent(Int.self, forKey: .followersCount)
        followingCount = try container.decodeIfPresent(Int.self, forKey: .followingCount)
        likesCount = try container.decodeIfPresent(Int.self, forKey: .likesCount)
        videoCount = try container.decodeIfPresent(Int.self, forKey: .videoCount)
        soldItemsCount = try container.decodeIfPresent(Int.self, forKey: .soldItemsCount)
        taggedProductsCount = try container.decodeIfPresent(Int.self, forKey: .taggedProductsCount)
        playlist = try container.decodeIfPresent([Playlist].self, forKey: .playlist)
        shop = try container.decodeIfPresent(Int.self, forKey: .shop)
        unreadNotification = try container.decodeIfPresent(Int.self, forKey: .unreadNotification)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(firstName, forKey: .firstName)
        try container.encodeIfPresent(lastName, forKey: .lastName)
        try container.encodeIfPresent(bio, forKey: .bio)
        try container.encodeIfPresent(website, forKey: .website)
        try container.encodeIfPresent(profilePic, forKey: .profilePic)
        try container.encodeIfPresent(username, forKey: .username)
        try container.encodeIfPresent(online, forKey: .online)
        try container.encodeIfPresent(verified, forKey: .verified)

        try container.encodeIfPresent(locationString, forKey: .locationString)
        try container.encodeIfPresent(countryID, forKey: .countryID)
        try container.encodeIfPresent(wallet, forKey: .wallet)
        try container.encodeIfPresent(paypal, forKey: .paypal)
        try container.encodeIfPresent(userPrivate, forKey: .userPrivate)
        try container.encodeIfPresent(profileView, forKey: .profileView)

        try container.encodeIfPresent(created, forKey: .created)
        try container.encodeIfPresent(parent, forKey: .parent)
        try container.encodeIfPresent(business, forKey: .business)
        try container.encodeIfPresent(story, forKey: .story)
      
        try container.encodeIfPresent(interests, forKey: .interests)
        try container.encodeIfPresent(followersCount, forKey: .followersCount)
        try container.encodeIfPresent(followingCount, forKey: .followingCount)
        try container.encodeIfPresent(likesCount, forKey: .likesCount)
        try container.encodeIfPresent(videoCount, forKey: .videoCount)
        try container.encodeIfPresent(soldItemsCount, forKey: .soldItemsCount)
        try container.encodeIfPresent(taggedProductsCount, forKey: .taggedProductsCount)
        try container.encodeIfPresent(playlist, forKey: .playlist)
        try container.encodeIfPresent(shop, forKey: .shop)
        try container.encodeIfPresent(unreadNotification, forKey: .unreadNotification)
    }
}
// MARK: - InterestElement
struct InterestElement: Codable {
    let userInterest: UserInterest?
    let interest: InterestInterest?

    enum CodingKeys: String, CodingKey {
        case userInterest = "UserInterest"
        case interest = "Interest"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userInterest = try container.decodeIfPresent(UserInterest.self, forKey: .userInterest)
        interest = try container.decodeIfPresent(InterestInterest.self, forKey: .interest)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(userInterest, forKey: .userInterest)
        try container.encodeIfPresent(interest, forKey: .interest)
    }
}

// MARK: - InterestInterest
struct InterestInterest: Codable {
    let id: Int?
    let interestSectionID: Int?
    let title: String?
    let order: Int?
    let created: String?

    enum CodingKeys: String, CodingKey {
        case id
        case interestSectionID = "interest_section_id"
        case title, order, created
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        interestSectionID = try container.decodeIfPresent(Int.self, forKey: .interestSectionID)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        order = try container.decodeIfPresent(Int.self, forKey: .order)
        created = try container.decodeIfPresent(String.self, forKey: .created)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(interestSectionID, forKey: .interestSectionID)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(order, forKey: .order)
        try container.encodeIfPresent(created, forKey: .created)
    }
}

/// MARK: - UserInterest
struct UserInterest: Codable {
    let id: Int?
    let userID: Int?
    let interestID: Int?
    let created: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case interestID = "interest_id"
        case created, name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        userID = try container.decodeIfPresent(Int.self, forKey: .userID)
        interestID = try container.decodeIfPresent(Int.self, forKey: .interestID)
        created = try container.decodeIfPresent(String.self, forKey: .created)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(userID, forKey: .userID)
        try container.encodeIfPresent(interestID, forKey: .interestID)
        try container.encodeIfPresent(created, forKey: .created)
        try container.encodeIfPresent(name, forKey: .name)
    }
}

// MARK: - Playlist
struct Playlist: Codable {
    let playlist: UserInterest?

    enum CodingKeys: String, CodingKey {
        case playlist = "Playlist"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        playlist = try container.decodeIfPresent(UserInterest.self, forKey: .playlist)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(playlist, forKey: .playlist)
    }
}
