//
//  ShowAllNotificationsModel.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 21/03/2025.
//


import Foundation

// MARK: - ShowAllNotificationsModel
struct ShowAllNotificationsModel: Codable {
    let code: Int
    let msg: [ShowAllNotificationsMsg]?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case code, msg
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        if code == 200 {
            msg = try container.decodeIfPresent([ShowAllNotificationsMsg].self, forKey: .msg)
            message = nil
        } else {
            msg = nil
            message = try container.decodeIfPresent(String.self, forKey: .msg)
        }
    }
}

// MARK: - Msg
struct ShowAllNotificationsMsg: Codable {
    let notification: Notification
    let video: ShowAllNotificationsVideo?
    let sender: Receiver
    let receiver: Receiver

    enum CodingKeys: String, CodingKey {
        case notification = "Notification"
        case video = "Video"
        case sender = "Sender"
        case receiver = "Receiver"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        notification = try container.decode(Notification.self, forKey: .notification)
        video = try container.decodeIfPresent(ShowAllNotificationsVideo.self, forKey: .video)
        sender = try container.decode(Receiver.self, forKey: .sender)
        receiver = try container.decode(Receiver.self, forKey: .receiver)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(notification, forKey: .notification)
        try container.encodeIfPresent(video, forKey: .video)
        try container.encode(sender, forKey: .sender)
        try container.encode(receiver, forKey: .receiver)
    }
}

// MARK: - Notification
struct Notification: Codable {
    let id: Int
    let senderID: Int
    let receiverID: Int
    let string: String
    let type: String
    let videoID: Int
    let liveStreamingID: Int
    let roomID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case senderID = "sender_id"
        case receiverID = "receiver_id"
        case string, type
        case videoID = "video_id"
        case liveStreamingID = "live_streaming_id"
        case roomID = "room_id"
    }

    // MARK: - Decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        senderID = try container.decodeIfPresent(Int.self, forKey: .senderID) ?? 0
        receiverID = try container.decodeIfPresent(Int.self, forKey: .receiverID) ?? 0
        string = try container.decodeIfPresent(String.self, forKey: .string) ?? "0"
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? "0"
        videoID = try container.decodeIfPresent(Int.self, forKey: .videoID) ?? 0
        liveStreamingID = try container.decodeIfPresent(Int.self, forKey: .liveStreamingID) ?? 0
        roomID = try container.decodeIfPresent(Int.self, forKey: .roomID) ?? 0
    }

    // MARK: - Encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(senderID, forKey: .senderID)
        try container.encodeIfPresent(receiverID, forKey: .receiverID)
        try container.encodeIfPresent(string, forKey: .string)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(videoID, forKey: .videoID)
        try container.encodeIfPresent(liveStreamingID, forKey: .liveStreamingID)
        try container.encodeIfPresent(roomID, forKey: .roomID)
    }
}

// MARK: - Receiver
struct Receiver: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let profilePic: String
    let username: String?
    let verified: Int

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case verified
        case username
    }

    // MARK: - Decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        profilePic = try container.decode(String.self, forKey: .profilePic)
        verified = try container.decode(Int.self, forKey: .verified)
        username = try container.decodeIfPresent(String.self, forKey: .username)
    }

    // MARK: - Encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(profilePic, forKey: .profilePic)
        try container.encode(verified, forKey: .verified)
        try container.encodeIfPresent(username, forKey: .username)
    }
}

// MARK: - Video
struct ShowAllNotificationsVideo: Codable {
    let id: Int?
    let userID: Int?
    let description: String?
    let video: String?
    let thum: String?
    let view: Int?
    let allowComments: String?
    let duration: Double?
    let promote: Int?
    let repostUserID: Int?
    let repostVideoID: Int?
    let qualityCheck: Int?
    let viral: Int?
    let locationString: String?
    let share: Int?
    let lat: String?
    let long: String?
    let nudityFound: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case thum
        case description, video, view
        case allowComments = "allow_comments"
        case duration, promote
        case repostUserID = "repost_user_id"
        case repostVideoID = "repost_video_id"
        case qualityCheck = "quality_check"
        case viral
        case locationString = "location_string"
        case share, lat, long
        case nudityFound = "nudity_found"
    }

    // MARK: - Decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        userID = try container.decodeIfPresent(Int.self, forKey: .userID)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        thum = try container.decodeIfPresent(String.self, forKey: .thum)
        video = try container.decodeIfPresent(String.self, forKey: .video)
        view = try container.decodeIfPresent(Int.self, forKey: .view)
        allowComments = try container.decodeIfPresent(String.self, forKey: .allowComments)
        duration = try container.decodeIfPresent(Double.self, forKey: .duration)
        promote = try container.decodeIfPresent(Int.self, forKey: .promote)
        repostUserID = try container.decodeIfPresent(Int.self, forKey: .repostUserID)
        repostVideoID = try container.decodeIfPresent(Int.self, forKey: .repostVideoID)
        qualityCheck = try container.decodeIfPresent(Int.self, forKey: .qualityCheck)
        viral = try container.decodeIfPresent(Int.self, forKey: .viral)
        locationString = try container.decodeIfPresent(String.self, forKey: .locationString)
        share = try container.decodeIfPresent(Int.self, forKey: .share)
        lat = try container.decodeIfPresent(String.self, forKey: .lat)
        long = try container.decodeIfPresent(String.self, forKey: .long)
        nudityFound = try container.decodeIfPresent(Int.self, forKey: .nudityFound)
    }

    // MARK: - Encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(userID, forKey: .userID)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(thum, forKey: .thum)
        try container.encodeIfPresent(video, forKey: .video)
        try container.encodeIfPresent(view, forKey: .view)
        try container.encodeIfPresent(allowComments, forKey: .allowComments)
        try container.encodeIfPresent(duration, forKey: .duration)
        try container.encodeIfPresent(promote, forKey: .promote)
        try container.encodeIfPresent(repostUserID, forKey: .repostUserID)
        try container.encodeIfPresent(repostVideoID, forKey: .repostVideoID)
        try container.encodeIfPresent(qualityCheck, forKey: .qualityCheck)
        try container.encodeIfPresent(viral, forKey: .viral)
        try container.encodeIfPresent(locationString, forKey: .locationString)
        try container.encodeIfPresent(share, forKey: .share)
        try container.encodeIfPresent(lat, forKey: .lat)
        try container.encodeIfPresent(long, forKey: .long)
        try container.encodeIfPresent(nudityFound, forKey: .nudityFound)
    }
}
