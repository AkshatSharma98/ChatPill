//
//  ChatManager.swift
//  ChatPill
//
//  Created by Akshat Sharma on 16/01/22.
//

import Foundation

class ChatMessage: Codable {
    let message: String?
    let type: ChatType?
    
    init(message: String?, type: ChatType?) {
        self.message = message
        self.type = type
    }
}

class ChatHistory {
    let name: String?
    let id: String?
    let messages: [ChatMessage]?
    
    init(name: String?, id: String?, messages: [ChatMessage]?) {
        self.name = name
        self.id = id
        self.messages = messages
    }
}

protocol ChatManagerProtocol: AnyObject {
    func saveChatMessage(for id: String, name: String, chatMessage: ChatMessage)
    func retrieveAllMessage(from id: String) -> [ChatMessage]?
}


class ChatManager: ChatManagerProtocol {
    
    let cdChatRepo: CDChatRepo = CDChatRepo()
    
    func saveChatMessage(for id: String, name: String, chatMessage: ChatMessage) {
        cdChatRepo.saveChatMessage(for: id, name: name, chatMessage: chatMessage)
    }
    
    
    func retrieveAllMessage(from id: String) -> [ChatMessage]? {
        return cdChatRepo.retrieveAllMessage(from: id)
    }
}
