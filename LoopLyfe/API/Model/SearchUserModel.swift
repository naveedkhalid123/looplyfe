//
//  SearchUserModel.swift
//  LoopLyfe
//
//  Created by iMac on 11/12/2025.
//

import Foundation

// MARK: - SearchUserModel
struct SearchUserModel: Codable {
    let code: Int
    var msg: [SearchUserMsg]?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case code, msg
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        if code == 200 {
            msg = try container.decodeIfPresent([SearchUserMsg].self, forKey: .msg)
            message = nil
        } else {
            msg = nil
            message = try container.decodeIfPresent(String.self, forKey: .msg)
        }
    }
}

// MARK: - Msg
struct SearchUserMsg: Codable {
    let user: User

    enum CodingKeys: String, CodingKey {
        case user = "User"
    }
}


