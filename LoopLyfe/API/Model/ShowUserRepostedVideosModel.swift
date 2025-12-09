//
//  ShowUserRepostedVideosModel.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 24/03/2025.
//

import Foundation

// MARK: - ShowUserRepostedVideosModel
struct ShowUserRepostedVideosModel: Codable {
    let code: Int
    let msg: [RepostedVideosMsg]?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case code, msg
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)

        if code == 200 {
            msg = try container.decodeIfPresent([RepostedVideosMsg].self, forKey: .msg)
            message = nil
        } else {
            msg = nil
            message = try container.decodeIfPresent(String.self, forKey: .msg)
        }
    }
}

// MARK: - Msg
struct RepostedVideosMsg: Codable {
    let repostVideo: RepostVideo
    let video: UserRepostedVideo
    let user: RepostedVideosUser

    enum CodingKeys: String, CodingKey {
        case repostVideo = "RepostVideo"
        case video = "Video"
        case user = "User"
    }
}

// MARK: - RepostVideo
struct RepostVideo: Codable {
    let id, userID: Int
    let videoID: Int?
    let created: String
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case videoID = "video_id"
        case created, name
    }
}

// MARK: - User
struct RepostedVideosUser: Codable {
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
struct UserRepostedVideo: Codable {
    let id, userID: Int
    let description: String
    let video: String
    let thum: String
    let thumSmall: Int
    let gif: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case description, video, thum
        case thumSmall = "thum_small"
        case gif
    }
}
