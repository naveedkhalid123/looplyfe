import Foundation

// MARK: - SearchVideosModel
struct SearchVideosModel: Codable {
    let code: Int
    var msg: [SearchVideosMsg]?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case code, msg
    }

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
}

// MARK: - SearchVideosMsg
struct SearchVideosMsg: Codable {
    let video: Video
    let pinComment: PinComment
    let user: User
    let location: Location
    let sound: Sound

    enum CodingKeys: String, CodingKey {
        case video = "Video"
        case pinComment = "PinComment"
        case user = "User"
        case location = "Location"
        case sound = "Sound"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        video = try container.decode(Video.self, forKey: .video)
        pinComment = try container.decode(PinComment.self, forKey: .pinComment)
        user = try container.decode(User.self, forKey: .user)
        location = try container.decode(Location.self, forKey: .location)
        sound = try container.decode(Sound.self, forKey: .sound)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(video, forKey: .video)
        try container.encode(pinComment, forKey: .pinComment)
        try container.encode(user, forKey: .user)
        try container.encode(location, forKey: .location)
        try container.encode(sound, forKey: .sound)
    }
}

