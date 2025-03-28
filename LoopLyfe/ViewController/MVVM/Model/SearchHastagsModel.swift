import Foundation

// MARK: - SearchHastagsModel
struct SearchHastagsModel: Codable {
    let code: Int
    let msg: [HastagsMsg]?
    let message: String?

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

    // Custom initializer for manual instantiation
    init(code: Int, msg: [HastagsMsg]? = nil, message: String? = nil) {
        self.code = code
        self.msg = msg
        self.message = message
    }
}

// MARK: - HastagsMsg
struct HastagsMsg: Codable {
    let hashtag: Hashtag

    enum CodingKeys: String, CodingKey {
        case hashtag = "Hashtag"
    }
}

// MARK: - Hashtag
struct Hashtag: Codable {
    let id: Int
    let name: String
    let videosCount: Int
    let views: String
    let favourite: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case videosCount = "videos_count"
        case views, favourite
    }
}
