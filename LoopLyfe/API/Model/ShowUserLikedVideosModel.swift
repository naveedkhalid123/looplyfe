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
    var msg: [Private]?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case code, msg
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try container.decode(Int.self, forKey: .code)
        if code == 200 {
            msg = try container.decodeIfPresent([Private].self, forKey: .msg)
            message = nil
        }
        else {
            msg = nil
            message = try container.decodeIfPresent(String.self, forKey: .msg)
        }
    }
}
