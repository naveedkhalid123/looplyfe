////
////  ShowUserLikedVideosModel.swift
////  LoopLyfe
////
////  Created by Naveed Khalid on 20/03/2025.
////
//
//import Foundation
//
//// MARK: - ShowUserLikedVideosModel
//struct ShowUserLikedVideosModel: Codable {
//    let code: Int
//    let msg: [ShowUserLikedVideosModelMsg]
//    let likedVideosMsg: String?
//}
//
//// MARK: - Msg
//struct ShowUserLikedVideosModelMsg: Codable {
//    let video: Video
//    let videoProduct: String?
//    let pinComment: PinComment
//    let user: ShowUserLikedVideosModelUser
//    let location: Location
//    let sound: Sound
//
//    enum CodingKeys: String, CodingKey {
//        case video = "Video"
//        case videoProduct = "VideoProduct"
//        case pinComment = "PinComment"
//        case user = "User"
//        case location = "Location"
//        case sound = "Sound"
//    }
//}
//
//// MARK: - Location
//struct Location: Codable {
//    let id, name, string, lat: String?
//    let long, googlePlaceID, image, created: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, string, lat, long
//        case googlePlaceID = "google_place_id"
//        case image, created
//    }
//}
//
//// MARK: - PinComment
//struct PinComment: Codable {
//    let id: Int
//}
//
//// MARK: - Sound
//struct Sound: Codable {
//    let id: Int
//    let audio: String
//    let duration, name, description: String
//    let thum: String
//    let soundSectionID: Int
//    let uploadedBy: UploadedBy
//    let publish: Int
//    let created: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, audio, duration, name, description, thum
//        case soundSectionID = "sound_section_id"
//        case uploadedBy = "uploaded_by"
//        case publish, created
//    }
//}
//
//enum UploadedBy: String, Codable {
//    case admin = "admin"
//    case user = "user"
//}
//
//// MARK: - User
//struct ShowUserLikedVideosModelUser: Codable {
//    let id: Int
//    let firstName, lastName: String
//    let bio: Bio
//    let website: Website
//    let profilePic: String
//    let profilePicSmall: String
//    let profileGIF, deviceToken: String
//    let business, parent: Int
//    let username: String
//    let verified: Int
//    let button: Button
//    let block: Int
//    let story: String?
//    let followersCount, followingCount, likesCount, videoCount: Int
//    let shop, soldItemsCount, taggedProductsCount: Int
//    let playlist: [PlaylistElement]
//    let privacySetting: ShowUserLikedVideosPrivacySetting
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case bio, website
//        case profilePic = "profile_pic"
//        case profilePicSmall = "profile_pic_small"
//        case profileGIF = "profile_gif"
//        case deviceToken = "device_token"
//        case business, parent, username, verified, button, block, story
//        case followersCount = "followers_count"
//        case followingCount = "following_count"
//        case likesCount = "likes_count"
//        case videoCount = "video_count"
//        case shop
//        case soldItemsCount = "sold_items_count"
//        case taggedProductsCount = "tagged_products_count"
//        case playlist = "Playlist"
//        case privacySetting = "PrivacySetting"
//    }
//}
//
//enum Bio: String, Codable {
//    case bio = "??? ???? ?????? ?????? ??? ??????"
//    case empty = ""
//    case hello = "hello \u{1f9be}"
//}
//
//enum ShowUserLikedVideosButton: String, Codable {
//    case follow = "follow"
//    case followBack = "follow back"
//}
//
//// MARK: - PlaylistElement
//struct PlaylistElement: Codable {
//    let playlist: PlaylistPlaylist
//
//    enum CodingKeys: String, CodingKey {
//        case playlist = "Playlist"
//    }
//}
//
//// MARK: - PlaylistPlaylist
//struct PlaylistPlaylist: Codable {
//    let id, userID: Int
//    let name, created: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userID = "user_id"
//        case name, created
//    }
//}
//
//// MARK: - PrivacySetting
//struct ShowUserLikedVideosPrivacySetting: Codable {
//    let id, videosDownload: Int
//    let directMessage, duet: DirectMessage
//    let likedVideos: LikedVideos
//    let videoComment: DirectMessage
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case videosDownload = "videos_download"
//        case directMessage = "direct_message"
//        case duet
//        case likedVideos = "liked_videos"
//        case videoComment = "video_comment"
//    }
//}
//
//enum DirectMessage: String, Codable {
//    case everyone = "everyone"
//}
//
//enum LikedVideos: String, Codable {
//    case me = "me"
//    case noOne = "NO ONE"
//}
//
//enum Website: String, Codable {
//    case empty = ""
//    case wwwInstagramCOM = "www.instagram.com"
//    case wwwMooobyCOM = "Www.moooby.com\n\n"
//    case wwwTicticCOM = "www.tictic.com"
//}
//
//// MARK: - Video
//struct Video: Codable {
//    let id, userID: Int
//    let description: String
//    let video: String
//    let thum: String
//    let thumSmall: Int
//    let gif: String
//    let view, soundID: Int
//    let privacyType: PrivacyType
//    let allowComments: String
//    let allowDuet: Int
//    let duration: Double
//    let promote, pinCommentID, pin: Int
//    let locationString: String
//    let locationID: Int
//    let lat, long: String
//    let width, height: Int
//    let userThumbnail, defaultThumbnail: String
//    let playlistVideo: PlaylistVideo
//    let repost, like, favourite, favouriteCount: Int
//    let commentCount, likeCount: Int
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userID = "user_id"
//        case description, video, thum
//        case thumSmall = "thum_small"
//        case gif, view
//        case soundID = "sound_id"
//        case privacyType = "privacy_type"
//        case allowComments = "allow_comments"
//        case allowDuet = "allow_duet"
//        case duration, promote
//        case pinCommentID = "pin_comment_id"
//        case pin
//        case locationString = "location_string"
//        case locationID = "location_id"
//        case lat, long, width, height
//        case userThumbnail = "user_thumbnail"
//        case defaultThumbnail = "default_thumbnail"
//        case playlistVideo = "PlaylistVideo"
//        case repost, like, favourite
//        case favouriteCount = "favourite_count"
//        case commentCount = "comment_count"
//        case likeCount = "like_count"
//    }
//}
//
//// MARK: - PlaylistVideo
//struct PlaylistVideo: Codable {
//    let id: Int
//    let playlist: PlaylistPlaylist?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case playlist = "Playlist"
//    }
//}
//
//enum PrivacyType: String, Codable {
//    case privacyTypePrivate = "private"
//    case privacyTypePublic = "public"
//}
//
//

//
//  ShowUserLikedVideosModel.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/03/2025.
//

import Foundation

// MARK: - ShowUserLikedVideosModel
struct ShowUserLikedVideosModel: Codable {
    let code: Int
    let msg: [ShowUserLikedVideosModelMsg]
    let likedVideosMsg: String?
}

// MARK: - Msg
struct ShowUserLikedVideosModelMsg: Codable {
    let video: Video
    let videoProduct: VideoProduct?
    let pinComment: PinComment
    let user: ShowUserLikedVideosModelUser
    let location: Location
    let sound: Sound

    enum CodingKeys: String, CodingKey {
        case video = "Video"
        case videoProduct = "VideoProduct"
        case pinComment = "PinComment"
        case user = "User"
        case location = "Location"
        case sound = "Sound"
    }
}

// MARK: - VideoProduct (Handles both String & Array)
enum VideoProduct: Codable {
    case string(String)
    case array([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else if let arrayValue = try? container.decode([String].self) {
            self = .array(arrayValue)
        } else {
            throw DecodingError.typeMismatch(VideoProduct.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected String or Array"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        case .array(let value):
            try container.encode(value)
        }
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
    let id: Int
    let audio: String
    let duration, name, description: String
    let thum: String
    let soundSectionID: Int
    let uploadedBy: UploadedBy
    let publish: Int
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, audio, duration, name, description, thum
        case soundSectionID = "sound_section_id"
        case uploadedBy = "uploaded_by"
        case publish, created
    }
}

enum UploadedBy: String, Codable {
    case admin = "admin"
    case user = "user"
}

// MARK: - User
struct ShowUserLikedVideosModelUser: Codable {
    let id: Int
    let firstName, lastName: String
    let bio: Bio
    let website: Website
    let profilePic: String
    let profilePicSmall: String
    let profileGIF, deviceToken: String
    let business, parent: Int
    let username: String
    let verified: Int
    let button: ShowUserLikedVideosButton
    let block: Int
    let story: String?
    let followersCount, followingCount, likesCount, videoCount: Int
    let shop, soldItemsCount, taggedProductsCount: Int
    let playlist: [PlaylistElement]
    let privacySetting: ShowUserLikedVideosPrivacySetting

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

enum Bio: String, Codable {
    case bio = "??? ???? ?????? ?????? ??? ??????"
    case empty = ""
    case hello = "hello \u{1f9be}"
}

enum ShowUserLikedVideosButton: String, Codable {
    case follow = "follow"
    case followBack = "follow back"
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
struct ShowUserLikedVideosPrivacySetting: Codable {
    let id, videosDownload: Int
    let directMessage, duet: DirectMessage
    let likedVideos: LikedVideos
    let videoComment: DirectMessage

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
}

enum LikedVideos: String, Codable {
    case me = "me"
    case noOne = "NO ONE"
}

enum Website: String, Codable {
    case empty = ""
    case wwwInstagramCOM = "www.instagram.com"
    case wwwMooobyCOM = "Www.moooby.com\n\n"
    case wwwTicticCOM = "www.tictic.com"
}

// MARK: - Video
struct Video: Codable {
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
}
