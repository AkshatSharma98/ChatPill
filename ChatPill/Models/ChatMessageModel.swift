//
//  ChatMessageModel.swift
//  ChatPill
//
//  Created by Akshat Sharma on 16/01/22.
//

import Foundation

enum ChatType: Codable {
    case received
    case sent
}

final class ChatMessageModel {
    let text: String?
    let type: ChatType
    
    init(text: String?, type: ChatType) {
        self.text = text
        self.type = type
    }
}
