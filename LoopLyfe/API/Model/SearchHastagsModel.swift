import Foundation

// MARK: - SearchHastagsModel
struct SearchHastagsModel: Codable {
    let code: Int
    var msg: [HastagsMsg]?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case code, msg
    }

    // Custom decoder init
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)

        if code == 200 {
            msg = try container.decodeIfPresent([HastagsMsg].self, forKey: .msg)
            message = nil
        } else {
            msg = nil
            message = try container.decodeIfPresent(String.self, forKey: .msg)
        }
    }
}

// MARK: - HastagsMsg
struct HastagsMsg: Codable {
    let hashtag: Hashtag?

    enum CodingKeys: String, CodingKey {
        case hashtag = "Hashtag"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hashtag = try container.decodeIfPresent(Hashtag.self, forKey: .hashtag)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(hashtag, forKey: .hashtag)
    }
}

// MARK: - Hashtag
struct Hashtag: Codable {
    let id: Int?
    let name: String?
    let videosCount: Int?
    let views: String?
    let favourite: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case videosCount = "videos_count"
        case views
        case favourite
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        videosCount = try container.decodeIfPresent(Int.self, forKey: .videosCount)
        views = try container.decodeIfPresent(String.self, forKey: .views)
        favourite = try container.decodeIfPresent(Int.self, forKey: .favourite)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(videosCount, forKey: .videosCount)
        try container.encodeIfPresent(views, forKey: .views)
        try container.encodeIfPresent(favourite, forKey: .favourite)
    }
}
