//
//  UsersDTO.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation

//DTO - Data Transmission Object
struct UsersDTO: Decodable {
    
    let userName: String?
    let profileImgUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case userName = "login"
        case profileImgUrl = "avatar_url"
    }
}
