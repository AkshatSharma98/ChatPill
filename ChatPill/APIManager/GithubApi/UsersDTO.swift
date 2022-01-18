//
//  UsersDTO.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation

class UsersDTO: Decodable {
    let userName: String?
    let profileImgUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case userName = "login"
        case profileImgUrl = "avatar_url"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userName = try? container.decodeIfPresent(String.self, forKey: .userName)
        profileImgUrl = try? container.decodeIfPresent(String.self, forKey: .profileImgUrl)
    }
}
