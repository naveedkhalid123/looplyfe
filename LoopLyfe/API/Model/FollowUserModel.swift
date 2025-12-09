//
//  FollowUserModel.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 19/03/2025.
//

import Foundation

// MARK: - FollowUserModel
struct FollowUserModel: Codable {
    let code: Int
    let msg: FollowUSerMsg
}

// MARK: - Msg
struct FollowUSerMsg: Codable {
    let user: FollowUser

    enum CodingKeys: String, CodingKey {
        case user = "User"
    }
}

// MARK: - User
struct FollowUser: Codable {
    let id: Int
    let button: String

    enum CodingKeys: String, CodingKey {
        case id
        case button
    }
}
