//
//  ShowVideosModel.swift
//  LoopLyfe
//
//  Created by iMac on 25/11/2025.
//


import Foundation

// MARK: - ShowVideosModel
struct ShowVideosModel: Codable {
    let code: Int
    let msg: VideoMsg?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case code, msg
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        
        if code == 200 {
            msg = try container.decodeIfPresent(VideoMsg.self, forKey: .msg)
            message = nil
        } else {
            msg = nil
            message = try container.decodeIfPresent(String.self, forKey: .msg)
        }
    }
}


// MARK: - Msg
struct VideoMsg: Codable {
    let msgPublic: [Private]?
    let msgPrivate: [Private]?

    enum CodingKeys: String, CodingKey {
        case msgPublic = "public"
        case msgPrivate = "private"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        msgPublic = try container.decodeIfPresent([Private].self, forKey: .msgPublic)
        msgPrivate = try container.decodeIfPresent([Private].self, forKey: .msgPrivate)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(msgPublic, forKey: .msgPublic)
        try container.encodeIfPresent(msgPrivate, forKey: .msgPrivate)
    }
}


// MARK: - Private
struct Private: Codable {
    let video: Video?
    let pinComment: PinComment?
    let user: User?
    let location: Location?
    let sound: Sound?

    enum CodingKeys: String, CodingKey {
        case video = "Video"
        case pinComment = "PinComment"
        case user = "User"
        case location = "Location"
        case sound = "Sound"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        video = try container.decodeIfPresent(Video.self, forKey: .video)
        pinComment = try container.decodeIfPresent(PinComment.self, forKey: .pinComment)
        user = try container.decodeIfPresent(User.self, forKey: .user)
        location = try container.decodeIfPresent(Location.self, forKey: .location)
        sound = try container.decodeIfPresent(Sound.self, forKey: .sound)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(video, forKey: .video)
        try container.encodeIfPresent(pinComment, forKey: .pinComment)
        try container.encodeIfPresent(user, forKey: .user)
        try container.encodeIfPresent(location, forKey: .location)
        try container.encodeIfPresent(sound, forKey: .sound)
    }
}

// MARK: - Location
struct Location: Codable {
    let id: String?
    let name: String?
    let string: String?
    let lat: String?
    let long: String?
    let googlePlaceID: String?
    let image: String?
    let created: String?

    enum CodingKeys: String, CodingKey {
        case id, name, string, lat, long
        case googlePlaceID = "google_place_id"
        case image, created
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        string = try container.decodeIfPresent(String.self, forKey: .string)
        lat = try container.decodeIfPresent(String.self, forKey: .lat)
        long = try container.decodeIfPresent(String.self, forKey: .long)
        googlePlaceID = try container.decodeIfPresent(String.self, forKey: .googlePlaceID)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        created = try container.decodeIfPresent(String.self, forKey: .created)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(string, forKey: .string)
        try container.encodeIfPresent(lat, forKey: .lat)
        try container.encodeIfPresent(long, forKey: .long)
        try container.encodeIfPresent(googlePlaceID, forKey: .googlePlaceID)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encodeIfPresent(created, forKey: .created)
    }
}
// MARK: - PinComment
struct PinComment: Codable {
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case id
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
    }
}

// MARK: - Sound
struct Sound: Codable {
    let id: Int?
    let audio: String?
    let duration: String?
    let name: String?
    let description: String?
    let thum: String?
    let soundSectionID: Int?
    let uploadedBy: String?
    let publish: Int?
    let created: String?

    enum CodingKeys: String, CodingKey {
        case id, audio, duration, name, description, thum
        case soundSectionID = "sound_section_id"
        case uploadedBy = "uploaded_by"
        case publish, created
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        audio = try container.decodeIfPresent(String.self, forKey: .audio)
        duration = try container.decodeIfPresent(String.self, forKey: .duration)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        thum = try container.decodeIfPresent(String.self, forKey: .thum)
        soundSectionID = try container.decodeIfPresent(Int.self, forKey: .soundSectionID)
        uploadedBy = try container.decodeIfPresent(String.self, forKey: .uploadedBy)
        publish = try container.decodeIfPresent(Int.self, forKey: .publish)
        created = try container.decodeIfPresent(String.self, forKey: .created)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(audio, forKey: .audio)
        try container.encodeIfPresent(duration, forKey: .duration)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(thum, forKey: .thum)
        try container.encodeIfPresent(soundSectionID, forKey: .soundSectionID)
        try container.encodeIfPresent(uploadedBy, forKey: .uploadedBy)
        try container.encodeIfPresent(publish, forKey: .publish)
        try container.encodeIfPresent(created, forKey: .created)
    }
}
// MARK: - Video
struct Video: Codable {
    let id: Int?
    let userID: Int?
    let description: String?
    let video: String?
    let thum: String?
    let thumSmall: Int?
    let gif: String?
    let view: Int?
    let soundID: Int?
    let privacyType: String?
    let allowComments: String?
    let allowDuet: Int?
    let duration: Double?
    let promote: Int?
    let pinCommentID: Int?
    let pin: Int?
    let locationString: String?
    let locationID: Int?
    let lat: String?
    let long: String?
    let width: Int?
    let height: Int?
    let userThumbnail: String?
    let defaultThumbnail: String?
    let playlistVideo: PinComment?
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

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decodeIfPresent(Int.self, forKey: .id)
        userID = try c.decodeIfPresent(Int.self, forKey: .userID)
        description = try c.decodeIfPresent(String.self, forKey: .description)
        video = try c.decodeIfPresent(String.self, forKey: .video)
        thum = try c.decodeIfPresent(String.self, forKey: .thum)
        thumSmall = try c.decodeIfPresent(Int.self, forKey: .thumSmall)
        gif = try c.decodeIfPresent(String.self, forKey: .gif)
        view = try c.decodeIfPresent(Int.self, forKey: .view)
        soundID = try c.decodeIfPresent(Int.self, forKey: .soundID)
        privacyType = try c.decodeIfPresent(String.self, forKey: .privacyType)
        allowComments = try c.decodeIfPresent(String.self, forKey: .allowComments)
        allowDuet = try c.decodeIfPresent(Int.self, forKey: .allowDuet)
        duration = try c.decodeIfPresent(Double.self, forKey: .duration)
        promote = try c.decodeIfPresent(Int.self, forKey: .promote)
        pinCommentID = try c.decodeIfPresent(Int.self, forKey: .pinCommentID)
        pin = try c.decodeIfPresent(Int.self, forKey: .pin)
        locationString = try c.decodeIfPresent(String.self, forKey: .locationString)
        locationID = try c.decodeIfPresent(Int.self, forKey: .locationID)
        lat = try c.decodeIfPresent(String.self, forKey: .lat)
        long = try c.decodeIfPresent(String.self, forKey: .long)
        width = try c.decodeIfPresent(Int.self, forKey: .width)
        height = try c.decodeIfPresent(Int.self, forKey: .height)
        userThumbnail = try c.decodeIfPresent(String.self, forKey: .userThumbnail)
        defaultThumbnail = try c.decodeIfPresent(String.self, forKey: .defaultThumbnail)
        playlistVideo = try c.decodeIfPresent(PinComment.self, forKey: .playlistVideo)
        repost = try c.decodeIfPresent(Int.self, forKey: .repost)
        like = try c.decodeIfPresent(Int.self, forKey: .like)
        favourite = try c.decodeIfPresent(Int.self, forKey: .favourite)
        favouriteCount = try c.decodeIfPresent(Int.self, forKey: .favouriteCount)
        commentCount = try c.decodeIfPresent(Int.self, forKey: .commentCount)
        likeCount = try c.decodeIfPresent(Int.self, forKey: .likeCount)
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encodeIfPresent(id, forKey: .id)
        try c.encodeIfPresent(userID, forKey: .userID)
        try c.encodeIfPresent(description, forKey: .description)
        try c.encodeIfPresent(video, forKey: .video)
        try c.encodeIfPresent(thum, forKey: .thum)
        try c.encodeIfPresent(thumSmall, forKey: .thumSmall)
        try c.encodeIfPresent(gif, forKey: .gif)
        try c.encodeIfPresent(view, forKey: .view)
        try c.encodeIfPresent(soundID, forKey: .soundID)
        try c.encodeIfPresent(privacyType, forKey: .privacyType)
        try c.encodeIfPresent(allowComments, forKey: .allowComments)
        try c.encodeIfPresent(allowDuet, forKey: .allowDuet)
        try c.encodeIfPresent(duration, forKey: .duration)
        try c.encodeIfPresent(promote, forKey: .promote)
        try c.encodeIfPresent(pinCommentID, forKey: .pinCommentID)
        try c.encodeIfPresent(pin, forKey: .pin)
        try c.encodeIfPresent(locationString, forKey: .locationString)
        try c.encodeIfPresent(locationID, forKey: .locationID)
        try c.encodeIfPresent(lat, forKey: .lat)
        try c.encodeIfPresent(long, forKey: .long)
        try c.encodeIfPresent(width, forKey: .width)
        try c.encodeIfPresent(height, forKey: .height)
        try c.encodeIfPresent(userThumbnail, forKey: .userThumbnail)
        try c.encodeIfPresent(defaultThumbnail, forKey: .defaultThumbnail)
        try c.encodeIfPresent(playlistVideo, forKey: .playlistVideo)
        try c.encodeIfPresent(repost, forKey: .repost)
        try c.encodeIfPresent(like, forKey: .like)
        try c.encodeIfPresent(favourite, forKey: .favourite)
        try c.encodeIfPresent(favouriteCount, forKey: .favouriteCount)
        try c.encodeIfPresent(commentCount, forKey: .commentCount)
        try c.encodeIfPresent(likeCount, forKey: .likeCount)
    }
}
