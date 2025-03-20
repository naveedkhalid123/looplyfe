//
//   ShowFollowingModel .swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 19/03/2025.
//

import Foundation

struct ShowFollowingModel: Codable {
    let code: Int
    let msg: [ShowFollowingMsg]?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case code, msg
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)

        if let msgArray = try? container.decode([ShowFollowingMsg].self, forKey: .msg) {
            msg = msgArray
            message = nil
        }
     
        else if let msgString = try? container.decode(String.self, forKey: .msg) {
            msg = nil
            message = msgString
        }

        else {
            msg = nil
            message = nil
        }
    }
}

// MARK: - Msg
struct ShowFollowingMsg: Codable {
    let follower: ShowFollowing
    let user: ShowFollowingUser

    enum CodingKeys: String, CodingKey {
        case follower = "Follower"
        case user = "User"
    }
}

// MARK: - Follower
struct ShowFollowing: Codable {
    let id, senderID, receiverID, notification: Int
    let promotionID: Int
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
struct ShowFollowingUser: Codable {
    let id: Int
    let firstName, lastName: String
    let profilePic: String
    let username: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case username
    }
}

enum Button: String, Codable {
    case following = "following"
}




