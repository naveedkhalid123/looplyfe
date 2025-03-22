//
////  ShowVideosAgainstUserIDModel.swift
////  LoopLyfe
////
////  Created by Naveed Khalid on 20/03/2025.
////
//
//struct ShowVideosAgainstUserIDModel: Codable {
//    let code: Int
//    let msg: [Msg]?
//    let message: String?
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        code = try container.decode(Int.self, forKey: .code)
//        message = try? container.decode(String.self, forKey: .message)
//
//        // Handle msg as either an array or dictionary
//        if let msgArray = try? container.decode([Msg].self, forKey: .msg) {
//            msg = msgArray
//        } else if let msgObject = try? container.decode(Msg.self, forKey: .msg) {
//            msg = [msgObject]
//        } else {
//            msg = nil
//        }
//    }
//}
//
//// MARK: - Msg
//struct Msg: Codable {
//    let msgPublic, msgPrivate: [String]
//
//    enum CodingKeys: String, CodingKey {
////        case msgPublic = "public"
////        case msgPrivate = "private"
//        
//        init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//            self.msgPublic = try container.decodeIfPresent([HomeResponseMsg].self, forKey: .msgPublic) ?? []
//            self.msgPrivate = try container.decodeIfPresent([HomeResponseMsg].self, forKey: .msgPrivate) ?? []
//        }
//
//    }
//}


//  ShowVideosAgainstUserIDModel.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 20/03/2025.
//

struct ShowVideosAgainstUserIDModel: Codable {
    let code: Int
    let msg: [Msg]?
    let message: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        message = try? container.decode(String.self, forKey: .message)

        // Handle msg as either an array or a single object
        if let msgArray = try? container.decode([Msg].self, forKey: .msg) {
            msg = msgArray
        } else if let msgObject = try? container.decode(Msg.self, forKey: .msg) {
            msg = [msgObject]
        } else {
            msg = nil
        }
    }
}

// MARK: - Msg
struct Msg: Codable {
    let msgPublic: [HomeResponseMsg]
    let msgPrivate: [HomeResponseMsg]

    enum CodingKeys: String, CodingKey {
        case msgPublic = "msgPublic"
        case msgPrivate = "msgPrivate"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.msgPublic = try container.decodeIfPresent([HomeResponseMsg].self, forKey: .msgPublic) ?? []
        self.msgPrivate = try container.decodeIfPresent([HomeResponseMsg].self, forKey: .msgPrivate) ?? []
    }
}

// MARK: - HomeResponseMsg (Assuming this exists)
struct HomeResponseMsg: Codable {
    let id: Int
    let title: String
    let videoURL: String
}
