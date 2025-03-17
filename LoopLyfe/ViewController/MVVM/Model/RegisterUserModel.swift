//
//  RegisterUserModel.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 12/03/2025.
//


import Foundation

// MARK: - RegisterUserModel
struct RegisterUserModel: Codable {
    let code: Int
    var msg: RegisterUserMsg?
    var message: String?
    enum CodingKeys: String, CodingKey {
        case code, msg
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        if code == 200 {
            msg = try container.decodeIfPresent(RegisterUserMsg.self, forKey: .msg)
            message = nil
        } else {
            msg = nil
            message = try container.decodeIfPresent(String.self, forKey: .msg)
        }
    }
}

// MARK: - RegisterUserMsg
struct RegisterUserMsg: Codable {
    let user: User
    let pushNotification: PushNotification
    let privacySetting: PrivacySetting
    
    enum CodingKeys: String, CodingKey {
        case user = "User"
        case pushNotification = "PushNotification"
        case privacySetting = "PrivacySetting"
    }
}
