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
        case code, msg, message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        
        // ✅ Handle different types of `msg`
        if let msgObject = try? container.decode(RegisterUserMsg.self, forKey: .msg) {
            msg = msgObject
        } else if let msgString = try? container.decode(String.self, forKey: .msg) {
            message = msgString
        }
        
        // ✅ Decode `message` if present
        if message == nil {
            message = try container.decodeIfPresent(String.self, forKey: .message)
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
