//
//  SearchVideosModel.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 28/03/2025.
//


import Foundation

// MARK: - SearchVideosModel
struct SearchVideosModel: Codable {
    let code: Int
    var msg: [SearchVideosMsg]?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case code, msg
    }

    // Custom decoder init
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)

        if code == 200 {
            msg = try container.decodeIfPresent([SearchVideosMsg].self, forKey: .msg)
            message = nil
        } else {
            msg = nil
            message = try container.decodeIfPresent(String.self, forKey: .msg)
        }
    }

    // Custom initializer for manual instantiation
    init(code: Int, msg: [SearchVideosMsg]? = nil, message: String? = nil) {
        self.code = code
        self.msg = msg
        self.message = message
    }
}

// MARK: - SearchVideosMsg
struct SearchVideosMsg: Codable {
    let video: SearchVideo
    let pinComment: PinComment
    let user: SearchVideosUser
    let location: Location
    let sound: Sound

    enum CodingKeys: String, CodingKey {
        case video = "Video"
        case pinComment = "PinComment"
        case user = "User"
        case location = "Location"
        case sound = "Sound"
    }
}

// MARK: - Location
struct Location: Codable {
    let id, name, string, lat: String?
    let long, googlePlaceID, image, created: String?

    enum CodingKeys: String, CodingKey {
        case id, name, string, lat, long
        case googlePlaceID = "google_place_id"
        case image, created
    }
}

// MARK: - PinComment
struct PinComment: Codable {
    let id: Int
}

// MARK: - Sound
struct Sound: Codable {
    let id: Int?
    let audio: String?
    let duration, name, description: String?
    let thum: String?
    let soundSectionID: Int?
    let uploadedBy: UploadedBy?
    let publish: Int?
    let created: String?

    enum CodingKeys: String, CodingKey {
        case id, audio, duration, name, description, thum
        case soundSectionID = "sound_section_id"
        case uploadedBy = "uploaded_by"
        case publish, created
    }
}

enum UploadedBy: String, Codable {
    case user = "user"
}

// MARK: - SearchVideosUser
struct SearchVideosUser: Codable {
    let id: Int
    let firstName, lastName, bio: String
    let website, profilePic: String
    let profilePicSmall, profileGIF, deviceToken: String
    let business, parent: Int
    let username: String
    let verified: Int
    let button: VideosButton
    let block: Int
    let story: [String]
    let followersCount, followingCount, likesCount, videoCount: Int
    let shop, soldItemsCount, taggedProductsCount: Int
    let playlist: [PlaylistElement]
    let privacySetting: VideosPrivacySetting

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case bio, website
        case profilePic = "profile_pic"
        case profilePicSmall = "profile_pic_small"
        case profileGIF = "profile_gif"
        case deviceToken = "device_token"
        case business, parent, username, verified, button, block, story
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case likesCount = "likes_count"
        case videoCount = "video_count"
        case shop
        case soldItemsCount = "sold_items_count"
        case taggedProductsCount = "tagged_products_count"
        case playlist = "Playlist"
        case privacySetting = "PrivacySetting"
    }
}

enum VideosButton: String, Codable {
    case follow = "follow"
    case following = "following"
}

// MARK: - PlaylistElement
struct PlaylistElement: Codable {
    let playlist: PlaylistPlaylist

    enum CodingKeys: String, CodingKey {
        case playlist = "Playlist"
    }
}

// MARK: - PlaylistPlaylist
struct PlaylistPlaylist: Codable {
    let id, userID: Int
    let name, created: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case name, created
    }
}

// MARK: - PrivacySetting
struct VideosPrivacySetting: Codable {
    let id, videosDownload: Int
    let directMessage, duet, likedVideos, videoComment: DirectMessage

    enum CodingKeys: String, CodingKey {
        case id
        case videosDownload = "videos_download"
        case directMessage = "direct_message"
        case duet
        case likedVideos = "liked_videos"
        case videoComment = "video_comment"
    }
}

enum DirectMessage: String, Codable {
    case everyone = "everyone"
    case me = "me"
}

// MARK: - SearchVideo
struct SearchVideo: Codable {
    let id, userID: Int
    let description: String
    let video: String
    let thum: String
    let thumSmall: Int
    let gif: String
    let view, soundID: Int
    let privacyType: PrivacyType
    let allowComments: String
    let allowDuet: Int
    let duration: Double
    let promote, pinCommentID, pin: Int
    let locationString: String
    let locationID: Int
    let lat, long: String
    let width, height: Int
    let userThumbnail, defaultThumbnail: String
    let playlistVideo: PlaylistVideo
    let repost, like, favourite, favouriteCount: Int
    let commentCount, likeCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case description, video, thum
        case thumSmall = "thum_small"
        case gif, view
        case soundID = "sound_id"
        case privacyType = "privacy_type"
        case allowComments = "allow_comments"
        case allowDuet = "allow_duet"
        case duration, promote
        case pinCommentID = "pin_comment_id"
        case pin
        case locationString = "location_string"
        case locationID = "location_id"
        case lat, long, width, height
        case userThumbnail = "user_thumbnail"
        case defaultThumbnail = "default_thumbnail"
        case playlistVideo = "PlaylistVideo"
        case repost, like, favourite
        case favouriteCount = "favourite_count"
        case commentCount = "comment_count"
        case likeCount = "like_count"
    }
}

// MARK: - PlaylistVideo
struct PlaylistVideo: Codable {
    let id: Int
    let playlist: PlaylistPlaylist?

    enum CodingKeys: String, CodingKey {
        case id
        case playlist = "Playlist"
    }
}

enum PrivacyType: String, Codable {
    case privacyTypePrivate = "private"
    case privacyTypePublic = "public"
    case purplePrivate = "Private"
}
