
//  ShowVideosAgainstUserIDModel.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/03/2025.
//

import Foundation

// MARK: - ShowVideosAgainstUserIDModel
struct ShowVideosAgainstUserIDModel: Codable {
    let code: Int
    var msg: Msg?
    var message: String? 

    enum CodingKeys: String, CodingKey {
        case code, msg
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        if code == 200 {
            msg = try container.decodeIfPresent(Msg.self, forKey: .msg)
            message = nil
        } else {
            msg = nil
            message = try container.decodeIfPresent(String.self, forKey: .msg)
        }
    }
}

// MARK: - Msg
struct ShowUserRepostedVideosMsg: Codable {
    let msgPublic, msgPrivate: [Private]

    enum CodingKeys: String, CodingKey {
        case msgPublic = "public"
        case msgPrivate = "private"
    }
}

// MARK: - Private
struct Private: Codable {
    let video: UserVideo
    let user: VideoUser

    enum CodingKeys: String, CodingKey {
        case video = "Video"
        case user = "User"
    }
}

// MARK: - User
struct VideoUser: Codable {
    let id: Int
    let firstName, lastName: String
    let profilePic: String
    let profileGIF: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case profileGIF = "profile_gif"
    }
}

// MARK: - Video
struct UserVideo: Codable {
    let id, userID: Int
    let video: String
    let thum: String
    let gif: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case video, thum, gif
    }
}
