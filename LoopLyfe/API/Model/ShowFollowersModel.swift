
import Foundation

// MARK: - ShowFollowersModel
struct ShowFollowersModel: Codable {
    let code: Int
    let msg: [ShowFollowerMsg]?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case code
        case msg
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)

        if let msgArray = try? container.decode([ShowFollowerMsg].self, forKey: .msg) {
            msg = msgArray
            message = nil
        } else if let msgString = try? container.decode(String.self, forKey: .msg) {
            msg = nil
            message = msgString
        } else {
            msg = nil
            message = nil
        }
    }
}

// MARK: - Msg
struct ShowFollowerMsg: Codable {
    let follower: ShowFollower
    let user: ShowFollowerUser

    enum CodingKeys: String, CodingKey {
        case follower = "Follower"
        case user = "User"
    }
}

// MARK: - Follower
struct ShowFollower: Codable {
    let id, senderID, receiverID, notification, promotionID: Int
    let created: String

    enum CodingKeys: String, CodingKey {
        case id
        case senderID = "sender_id"
        case receiverID = "receiver_id"
        case notification
        case promotionID = "promotion_id"
        case created
    }
}

// MARK: - User
struct ShowFollowerUser: Codable {
    let id: Int
    let firstName, lastName, profilePic, username: String
    let button: Button

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case username
        case button
    }

    enum Button: String, Codable {
        case followBack = "follow back"
    }
}
