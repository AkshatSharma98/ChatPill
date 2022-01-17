//
//  CDChatRepo.swift
//  ChatPill
//
//  Created by Akshat Sharma on 16/01/22.
//

import Foundation
import CoreData

final class CDChatRepo: ChatManagerProtocol {
    
    func saveChatMessage(for id: String, name: String, chatMessage: ChatMessage) {
        guard let cdChat = getChatHistory(from: id) else {
            createChatHistory(for: id, name: name, chatMessage: chatMessage)
            return
        }
        
        let chatHistory = cdChat.convertToChatHistory()
        var messageArray = chatHistory?.messages
        
        messageArray?.append(chatMessage)
        cdChat.name = name
        cdChat.id = id
    
        if let array = messageArray {
            let newData = chatMessageArrayToData(chatArray: array)
            cdChat.messagesData = newData
            PersistentStorage.shared.saveContext()
        }
    }
    
    func retrieveAllMessage(from id: String) -> [ChatMessage]? {
        guard let cdChat = getChatHistory(from: id) else {
            return nil
        }
        let chatHistory = cdChat.convertToChatHistory()
        return chatHistory?.messages
    }
}

extension CDChatRepo {
    
    func getChatHistory(from id: String) -> CDChat? {
        
        let fetchRequest = NSFetchRequest<CDChat>(entityName: "CDChat")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        
        fetchRequest.predicate = predicate
        
        do {
            let cdChat = try PersistentStorage.shared.context.fetch(fetchRequest)
            if cdChat.count > 0 {
                return cdChat[0]
            }
        } catch {
            return nil
        }
        
        return nil
    }
    
    func createChatHistory(for id: String, name: String, chatMessage: ChatMessage) {
        let cdChat = CDChat(context: PersistentStorage.shared.context)
        cdChat.name = name
        cdChat.id = id
        var chatMessages = [ChatMessage]()
        chatMessages.append(chatMessage)
        
        let data = chatMessageArrayToData(chatArray: chatMessages)
        
        cdChat.messagesData = data
        PersistentStorage.shared.saveContext()
    }

    func chatMessageArrayToData(chatArray: [ChatMessage]) -> Data? {
      let data = try? JSONEncoder().encode(chatArray)
      return data
    }
}
