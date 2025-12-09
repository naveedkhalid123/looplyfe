//
//  SearchSoundModel.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 28/03/2025.
//

import Foundation

// MARK: - SearchSoundModel
struct SearchSoundModel: Codable {
    let code: Int
    var msg: [SoundMsg]?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case code, msg
    }

    // Custom decoder init
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)

        if code == 200 {
            msg = try container.decodeIfPresent([SoundMsg].self, forKey: .msg)
            message = nil
        } else {
            msg = nil
            message = try container.decodeIfPresent(String.self, forKey: .msg)
        }
    }

    // Custom initializer for manual instantiation
    init(code: Int, msg: [SoundMsg]? = nil, message: String? = nil) {
        self.code = code
        self.msg = msg
        self.message = message
    }
}

// MARK: - Msg
struct SoundMsg: Codable {
    let sound: SearchSound
    let soundSection: SoundSection

    enum CodingKeys: String, CodingKey {
        case sound = "Sound"
        case soundSection = "SoundSection"
    }
}

// MARK: - Sound
struct SearchSound: Codable {
    let id: Int
    let audio: String
    let duration, name, description: String
    let thum: String
    let soundSectionID: Int
    let uploadedBy: SoundUploadedBy
    let publish: Int
    let created: String
    let favourite: Int

    enum CodingKeys: String, CodingKey {
        case id, audio, duration, name, description, thum
        case soundSectionID = "sound_section_id"
        case uploadedBy = "uploaded_by"
        case publish, created, favourite
    }
}

enum SoundUploadedBy: String, Codable {
    case admin = "admin"
    case user = "user"
}

// MARK: - SoundSection
struct SoundSection: Codable {
    let id: Int
    let name: Name
}

enum Name: String, Codable {
    case trending = "Trending"
}
