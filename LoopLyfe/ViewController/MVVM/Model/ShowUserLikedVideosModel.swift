//
//  ShowUserLikedVideosModel.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/03/2025.
//


import Foundation

// MARK: - ShowUserLikedVideosModel
struct ShowUserLikedVideosModel: Codable {
    let code: Int
    let msg: [ShowUserLikedVideoMsg]?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case code, msg
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)

        if code == 200 {
            msg = try container.decodeIfPresent([ShowUserLikedVideoMsg].self, forKey: .msg)
            message = nil
        } else {
            msg = nil
            message = try container.decodeIfPresent(String.self, forKey: .msg)
        }
    }
}

// MARK: - ShowUserLikedVideoMsg
struct ShowUserLikedVideoMsg: Codable {
    let video: Video
    let videoProduct: [String]

    enum CodingKeys: String, CodingKey {
        case video = "Video"
        case videoProduct = "VideoProduct"
    }
}

// MARK: - Video
struct Video: Codable {
    let id, userID: Int
    let video: String
    let thum: String
    let thumSmall: Int
    let gif: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case video, thum
        case thumSmall = "thum_small"
        case gif
    }
}
