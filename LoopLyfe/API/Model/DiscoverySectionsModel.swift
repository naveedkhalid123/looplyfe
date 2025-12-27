//
//  DiscoverySectionsModel.swift
//  LoopLyfe
//
//  Created by iMac on 23/12/2025.
//


import Foundation

// MARK: - DiscoverySectionsModel
struct DiscoverySectionsModel: Codable {
    let code: Int
    var msg: [DiscoveryMsg]?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case code, msg
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        
        if code == 200 {
            msg = try container.decodeIfPresent([DiscoveryMsg].self, forKey: .msg)
            message = nil
        } else {
            msg = nil
            message = try container.decodeIfPresent(String.self, forKey: .msg)
        }
    }
}

// MARK: - DiscoveryMsg
struct DiscoveryMsg: Codable {
    let hashtag: MsgHashtag?

    enum CodingKeys: String, CodingKey {
        case hashtag = "Hashtag"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hashtag = try container.decodeIfPresent(MsgHashtag.self, forKey: .hashtag)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(hashtag, forKey: .hashtag)
    }
}


// MARK: - MsgHashtag
struct MsgHashtag: Codable {
    let id: Int?
    let name: String?
    let views: String?
    let videos: [VideoElement]?
    let videosCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, views
        case videos = "Videos"
        case videosCount = "videos_count"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        views = try container.decodeIfPresent(String.self, forKey: .views)
        videos = try container.decodeIfPresent([VideoElement].self, forKey: .videos)
        videosCount = try container.decodeIfPresent(Int.self, forKey: .videosCount)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(views, forKey: .views)
        try container.encodeIfPresent(videos, forKey: .videos)
        try container.encodeIfPresent(videosCount, forKey: .videosCount)
    }
}

// MARK: - VideoElement
struct VideoElement: Codable {
    let hashtagVideo: HashtagVideo?
    let hashtag: VideoHashtag?
    let video: VideoVideo?
    let videoProduct: [String]?
    let pinComment: PinComment?
    let user: User?
    let sound: Sound?

    enum CodingKeys: String, CodingKey {
        case hashtagVideo = "HashtagVideo"
        case hashtag = "Hashtag"
        case video = "Video"
        case videoProduct = "VideoProduct"
        case pinComment = "PinComment"
        case user = "User"
        case sound = "Sound"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hashtagVideo = try container.decodeIfPresent(HashtagVideo.self, forKey: .hashtagVideo)
        hashtag = try container.decodeIfPresent(VideoHashtag.self, forKey: .hashtag)
        video = try container.decodeIfPresent(VideoVideo.self, forKey: .video)
        videoProduct = try container.decodeIfPresent([String].self, forKey: .videoProduct)
        pinComment = try container.decodeIfPresent(PinComment.self, forKey: .pinComment)
        user = try container.decodeIfPresent(User.self, forKey: .user)
  
        sound = try container.decodeIfPresent(Sound.self, forKey: .sound)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(hashtagVideo, forKey: .hashtagVideo)
        try container.encodeIfPresent(hashtag, forKey: .hashtag)
        try container.encodeIfPresent(video, forKey: .video)
        try container.encodeIfPresent(videoProduct, forKey: .videoProduct)
        try container.encodeIfPresent(pinComment, forKey: .pinComment)
        try container.encodeIfPresent(user, forKey: .user)

        try container.encodeIfPresent(sound, forKey: .sound)
    }
}

// MARK: - VideoHashtag
struct VideoHashtag: Codable {
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id, name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
    }
}


// MARK: - HashtagVideo
struct HashtagVideo: Codable {
    let id: Int?
    let hashtagID: Int?
    let videoID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case hashtagID = "hashtag_id"
        case videoID = "video_id"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        hashtagID = try container.decodeIfPresent(Int.self, forKey: .hashtagID)
        videoID = try container.decodeIfPresent(Int.self, forKey: .videoID)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(hashtagID, forKey: .hashtagID)
        try container.encodeIfPresent(videoID, forKey: .videoID)
    }
}


// MARK: - UploadedBy
enum UploadedBy: String, Codable {
    case user = "user"
}

// MARK: - PlaylistElement
struct PlaylistElement: Codable {
    let playlist: PlaylistPlaylist?

    enum CodingKeys: String, CodingKey {
        case playlist = "Playlist"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        playlist = try container.decodeIfPresent(PlaylistPlaylist.self, forKey: .playlist)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(playlist, forKey: .playlist)
    }
}

// MARK: - PlaylistPlaylist
struct PlaylistPlaylist: Codable {
    let id: Int?
    let userID: Int?
    let name: String?
    let created: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case name, created
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        userID = try container.decodeIfPresent(Int.self, forKey: .userID)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        created = try container.decodeIfPresent(String.self, forKey: .created)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(userID, forKey: .userID)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(created, forKey: .created)
    }
}


enum Created: String, Codable {
    case the20230616055005 = "2023-06-16 05:50:05"
    case the20250307021657 = "2025-03-07 02:16:57"
    case the20250321035405 = "2025-03-21 03:54:05"
}

enum Name: String, Codable {
    case alimLove786 = "ALIM LOVE 786"
    case bollywoodHashtag = "bollywood hashtag"
    case slowMotion = "slow motion "
}

enum DirectMessage: String, Codable {
    case everyone = "everyone"
}

enum LikedVideos: String, Codable {
    case me = "me"
    case onlyMe = "only_me"
}

enum ProfilePicSmall: String, Codable {
    case appWebrootUploadsImages63203956951CAPNG = "app/webroot/uploads/images/63203956951ca.png"
    case empty = ""
}

enum Website: String, Codable {
    case beetteCOM = "beette.com"
    case empty = ""
}
// MARK: - VideoVideo
struct VideoVideo: Codable {
    let id: Int?
    let userID: Int?
    let description: String?
    let video: String?
    let thum: String?
    let thumSmall: Int?
    let gif: String?
    let view: Int?
    let section: String?
    let soundID: Int?
    let privacyType: PrivacyType?
    let allowComments: String?
    let allowDuet: Int?
    let block: Int?
    let duetVideoID: Int?
    let oldVideoID: Int?
    let duration: Double?
    let promote: Int?
    let pinCommentID: Int?
    let pin: Int?
    let repostUserID: Int?
    let repostVideoID: Int?
    let qualityCheck: Int?
    let viral: Int?
    let story: Int?
    let countryID: Int?
    let city: String?
    let state: String?
    let country: String?
    let region: String?
    let locationString: String?
    let share: Int?
    let videoWithWatermark: String?
    let lat: String?
    let long: String?
    let productID: String?
    let locationID: Int?
    let width: Int?
    let height: Int?
    let userThumbnail: String?
    let defaultThumbnail: String?
    let compression: Int?
    let nudityFound: Int?
    let error: Int?
    let created: String?
    let playlistVideo: PlaylistVideo?
    let repost: Int?
    let like: Int?
    let favourite: Int?
    let favouriteCount: Int?
    let commentCount: Int?
    let likeCount: Int?

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
        case playlistVideo = "PlaylistVideo"
        case repost, like, favourite
        case favouriteCount = "favourite_count"
        case commentCount = "comment_count"
        case likeCount = "like_count"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(Int.self, forKey: .id)
        userID = try container.decodeIfPresent(Int.self, forKey: .userID)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        video = try container.decodeIfPresent(String.self, forKey: .video)
        thum = try container.decodeIfPresent(String.self, forKey: .thum)
        thumSmall = try container.decodeIfPresent(Int.self, forKey: .thumSmall)
        gif = try container.decodeIfPresent(String.self, forKey: .gif)
        view = try container.decodeIfPresent(Int.self, forKey: .view)
        section = try container.decodeIfPresent(String.self, forKey: .section)
        soundID = try container.decodeIfPresent(Int.self, forKey: .soundID)
        privacyType = try container.decodeIfPresent(PrivacyType.self, forKey: .privacyType)
        allowComments = try container.decodeIfPresent(String.self, forKey: .allowComments)
        allowDuet = try container.decodeIfPresent(Int.self, forKey: .allowDuet)
        block = try container.decodeIfPresent(Int.self, forKey: .block)
        duetVideoID = try container.decodeIfPresent(Int.self, forKey: .duetVideoID)
        oldVideoID = try container.decodeIfPresent(Int.self, forKey: .oldVideoID)
        duration = try container.decodeIfPresent(Double.self, forKey: .duration)
        promote = try container.decodeIfPresent(Int.self, forKey: .promote)
        pinCommentID = try container.decodeIfPresent(Int.self, forKey: .pinCommentID)
        pin = try container.decodeIfPresent(Int.self, forKey: .pin)
        repostUserID = try container.decodeIfPresent(Int.self, forKey: .repostUserID)
        repostVideoID = try container.decodeIfPresent(Int.self, forKey: .repostVideoID)
        qualityCheck = try container.decodeIfPresent(Int.self, forKey: .qualityCheck)
        viral = try container.decodeIfPresent(Int.self, forKey: .viral)
        story = try container.decodeIfPresent(Int.self, forKey: .story)
        countryID = try container.decodeIfPresent(Int.self, forKey: .countryID)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        state = try container.decodeIfPresent(String.self, forKey: .state)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        region = try container.decodeIfPresent(String.self, forKey: .region)
        locationString = try container.decodeIfPresent(String.self, forKey: .locationString)
        share = try container.decodeIfPresent(Int.self, forKey: .share)
        videoWithWatermark = try container.decodeIfPresent(String.self, forKey: .videoWithWatermark)
        lat = try container.decodeIfPresent(String.self, forKey: .lat)
        long = try container.decodeIfPresent(String.self, forKey: .long)
        productID = try container.decodeIfPresent(String.self, forKey: .productID)
        locationID = try container.decodeIfPresent(Int.self, forKey: .locationID)
        width = try container.decodeIfPresent(Int.self, forKey: .width)
        height = try container.decodeIfPresent(Int.self, forKey: .height)
        userThumbnail = try container.decodeIfPresent(String.self, forKey: .userThumbnail)
        defaultThumbnail = try container.decodeIfPresent(String.self, forKey: .defaultThumbnail)
        compression = try container.decodeIfPresent(Int.self, forKey: .compression)
        nudityFound = try container.decodeIfPresent(Int.self, forKey: .nudityFound)
        error = try container.decodeIfPresent(Int.self, forKey: .error)
        created = try container.decodeIfPresent(String.self, forKey: .created)
        playlistVideo = try container.decodeIfPresent(PlaylistVideo.self, forKey: .playlistVideo)
        repost = try container.decodeIfPresent(Int.self, forKey: .repost)
        like = try container.decodeIfPresent(Int.self, forKey: .like)
        favourite = try container.decodeIfPresent(Int.self, forKey: .favourite)
        favouriteCount = try container.decodeIfPresent(Int.self, forKey: .favouriteCount)
        commentCount = try container.decodeIfPresent(Int.self, forKey: .commentCount)
        likeCount = try container.decodeIfPresent(Int.self, forKey: .likeCount)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(userID, forKey: .userID)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(video, forKey: .video)
        try container.encodeIfPresent(thum, forKey: .thum)
        try container.encodeIfPresent(thumSmall, forKey: .thumSmall)
        try container.encodeIfPresent(gif, forKey: .gif)
        try container.encodeIfPresent(view, forKey: .view)
        try container.encodeIfPresent(section, forKey: .section)
        try container.encodeIfPresent(soundID, forKey: .soundID)
        try container.encodeIfPresent(privacyType, forKey: .privacyType)
        try container.encodeIfPresent(allowComments, forKey: .allowComments)
        try container.encodeIfPresent(allowDuet, forKey: .allowDuet)
        try container.encodeIfPresent(block, forKey: .block)
        try container.encodeIfPresent(duetVideoID, forKey: .duetVideoID)
        try container.encodeIfPresent(oldVideoID, forKey: .oldVideoID)
        try container.encodeIfPresent(duration, forKey: .duration)
        try container.encodeIfPresent(promote, forKey: .promote)
        try container.encodeIfPresent(pinCommentID, forKey: .pinCommentID)
        try container.encodeIfPresent(pin, forKey: .pin)
        try container.encodeIfPresent(repostUserID, forKey: .repostUserID)
        try container.encodeIfPresent(repostVideoID, forKey: .repostVideoID)
        try container.encodeIfPresent(qualityCheck, forKey: .qualityCheck)
        try container.encodeIfPresent(viral, forKey: .viral)
        try container.encodeIfPresent(story, forKey: .story)
        try container.encodeIfPresent(countryID, forKey: .countryID)
        try container.encodeIfPresent(city, forKey: .city)
        try container.encodeIfPresent(state, forKey: .state)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(region, forKey: .region)
        try container.encodeIfPresent(locationString, forKey: .locationString)
        try container.encodeIfPresent(share, forKey: .share)
        try container.encodeIfPresent(videoWithWatermark, forKey: .videoWithWatermark)
        try container.encodeIfPresent(lat, forKey: .lat)
        try container.encodeIfPresent(long, forKey: .long)
        try container.encodeIfPresent(productID, forKey: .productID)
        try container.encodeIfPresent(locationID, forKey: .locationID)
        try container.encodeIfPresent(width, forKey: .width)
        try container.encodeIfPresent(height, forKey: .height)
        try container.encodeIfPresent(userThumbnail, forKey: .userThumbnail)
        try container.encodeIfPresent(defaultThumbnail, forKey: .defaultThumbnail)
        try container.encodeIfPresent(compression, forKey: .compression)
        try container.encodeIfPresent(nudityFound, forKey: .nudityFound)
        try container.encodeIfPresent(error, forKey: .error)
        try container.encodeIfPresent(created, forKey: .created)
        try container.encodeIfPresent(playlistVideo, forKey: .playlistVideo)
        try container.encodeIfPresent(repost, forKey: .repost)
        try container.encodeIfPresent(like, forKey: .like)
        try container.encodeIfPresent(favourite, forKey: .favourite)
        try container.encodeIfPresent(favouriteCount, forKey: .favouriteCount)
        try container.encodeIfPresent(commentCount, forKey: .commentCount)
        try container.encodeIfPresent(likeCount, forKey: .likeCount)
    }
}

// MARK: - PlaylistVideo
struct PlaylistVideo: Codable {
    let id: Int?
    let playlist: PlaylistPlaylist?

    enum CodingKeys: String, CodingKey {
        case id
        case playlist = "Playlist"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        playlist = try container.decodeIfPresent(PlaylistPlaylist.self, forKey: .playlist)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(playlist, forKey: .playlist)
    }
}

// MARK: - PrivacyType
enum PrivacyType: String, Codable {
    case privacyTypePublic = "public"
}
