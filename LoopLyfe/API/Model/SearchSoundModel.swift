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
}

// MARK: - SoundMsg
struct SoundMsg: Codable {
    let sound: SearchSound?
    let soundSection: SoundSection?

    enum CodingKeys: String, CodingKey {
        case sound = "Sound"
        case soundSection = "SoundSection"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        sound = try container.decodeIfPresent(SearchSound.self, forKey: .sound)
        soundSection = try container.decodeIfPresent(SoundSection.self, forKey: .soundSection)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(sound, forKey: .sound)
        try container.encodeIfPresent(soundSection, forKey: .soundSection)
    }
}
// MARK: - SearchSound
struct SearchSound: Codable {
    let id: Int?
    let audio: String?
    let duration: String?
    let name: String?
    let description: String?
    let thum: String?
    let soundSectionID: Int?
    let uploadedBy: String?
    let publish: Int?
    let created: String?
    let favourite: Int?

    enum CodingKeys: String, CodingKey {
        case id, audio, duration, name, description, thum
        case soundSectionID = "sound_section_id"
        case uploadedBy = "uploaded_by"
        case publish, created, favourite
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        audio = try container.decodeIfPresent(String.self, forKey: .audio)
        duration = try container.decodeIfPresent(String.self, forKey: .duration)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        thum = try container.decodeIfPresent(String.self, forKey: .thum)
        soundSectionID = try container.decodeIfPresent(Int.self, forKey: .soundSectionID)
        uploadedBy = try container.decodeIfPresent(String.self, forKey: .uploadedBy)
        publish = try container.decodeIfPresent(Int.self, forKey: .publish)
        created = try container.decodeIfPresent(String.self, forKey: .created)
        favourite = try container.decodeIfPresent(Int.self, forKey: .favourite)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(audio, forKey: .audio)
        try container.encodeIfPresent(duration, forKey: .duration)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(thum, forKey: .thum)
        try container.encodeIfPresent(soundSectionID, forKey: .soundSectionID)
        try container.encodeIfPresent(uploadedBy, forKey: .uploadedBy)
        try container.encodeIfPresent(publish, forKey: .publish)
        try container.encodeIfPresent(created, forKey: .created)
        try container.encodeIfPresent(favourite, forKey: .favourite)
    }
}

// MARK: - SoundSection
struct SoundSection: Codable {
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id, name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
    }
}
