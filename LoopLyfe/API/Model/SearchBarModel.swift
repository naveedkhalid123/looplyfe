//
//  SearchBarModel.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 27/03/2025.
//

import Foundation

// MARK: - SearchBarModel
struct SearchBarModel: Codable {
    let code: Int
    let msg: [SearchMsg]
    var message: String?

    enum CodingKeys: String, CodingKey {
        case code, msg, message
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        if code == 200 {
            msg = try container.decodeIfPresent([SearchMsg].self, forKey: .msg) ?? []
            message = nil
        } else {
            msg = []
            message = try container.decodeIfPresent(String.self, forKey: .message)
        }
    }
}

// MARK: - Msg
struct SearchMsg: Codable {
    let user: SearchUser

    enum CodingKeys: String, CodingKey {
        case user = "User"
    }
}

// MARK: - User
struct SearchUser: Codable {
    let id: Int
    let firstName, lastName, bio, website: String
    let profilePic: String
    let profilePicSmall, profileGIF, deviceToken: String
    let business, parent: Int
    let username: String
    let verified: Int
    let created, registerWith: String
    let active: Int
    let button: String
    let block: Int
    let story: [String]
    let followersCount, followingCount, likesCount, videoCount: Int
    let shop, soldItemsCount, taggedProductsCount: Int
    let playlist: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case bio, website
        case profilePic = "profile_pic"
        case profilePicSmall = "profile_pic_small"
        case profileGIF = "profile_gif"
        case deviceToken = "device_token"
        case business, parent, username, verified, created
        case registerWith = "register_with"
        case active, button, block, story
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case likesCount = "likes_count"
        case videoCount = "video_count"
        case shop
        case soldItemsCount = "sold_items_count"
        case taggedProductsCount = "tagged_products_count"
        case playlist = "Playlist"
    }
}
