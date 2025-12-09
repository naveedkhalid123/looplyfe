//
//  ShowSuggestedUsersModel.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 18/03/2025.
//


import Foundation

// MARK: - ShowSuggestedUsers
struct ShowSuggestedUsersModel: Codable {
    let code: Int
    var msg: [ShowSuggestedUsersMsg]?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case code, msg
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        if code == 200 {
            msg = try container.decodeIfPresent([ShowSuggestedUsersMsg].self, forKey: .msg)
            message = nil
        } else {
            msg = nil
            message = try container.decodeIfPresent(String.self, forKey: .msg)
        }
    }
}

// MARK: - ShowSuggestedUsersMsg
struct ShowSuggestedUsersMsg: Codable {
    let user: ShowSuggestedUsersUser

    enum CodingKeys: String, CodingKey {
        case user = "User"
    }
}

// MARK: - ShowSuggestedUsersUser
struct ShowSuggestedUsersUser: Codable {
    let id: Int
    let firstName, lastName: String
    let profilePic: String
    let username: String
    let authToken: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case username
        case authToken = "auth_token"
    }
}
