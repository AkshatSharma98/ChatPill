//
//  CDChat+CoreDataProperties.swift
//  ChatPill
//
//  Created by Akshat Sharma on 16/01/22.
//
//

import Foundation
import CoreData


extension CDChat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDChat> {
        return NSFetchRequest<CDChat>(entityName: "CDChat")
    }

    @NSManaged public var name: String?
    @NSManaged public var messagesData: Data?
    @NSManaged public var id: String?

}

extension CDChat : Identifiable {


    func convertToChatHistory() -> ChatHistory? {
        
        var messages: [ChatMessage]?
        if let messagesDataUnwrapped = messagesData {
            do {
                messages = try JSONDecoder().decode([ChatMessage].self,
                                                        from: messagesDataUnwrapped)
            } catch {
                
            }
        }
        return ChatHistory(name: name, id: id, messages: messages)
    }
    
    
}
