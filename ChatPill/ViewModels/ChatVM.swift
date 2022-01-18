//
//  ChatVM.swift
//  ChatPill
//
//  Created by Akshat Sharma on 16/01/22.
//

import Foundation

protocol ChatVMDelegate: AnyObject {
    func loadNewChat(_ forClass: ChatVM)
}

final class ChatVM {
    
    private let id: String
    private let name: String
    private var messages: [ChatMessageModel]?
    private var delegate: ChatVMDelegate?
    private var messageTime = 30
    private let chatManager = ChatManager()
    
    init(delegate: ChatVMDelegate?, name: String, id: String) {
        self.delegate = delegate
        self.id = id
        self.name = name
        let storedMessages = chatManager.retrieveAllMessage(from: id)
        messages = [ChatMessageModel]()
        storedMessages?.forEach({ chatMessage in
            messages?.append(ChatMessageModel(text: chatMessage.message,
                                              type: chatMessage.type ?? .received))
        })
    }
    
    func numberOfRows() -> Int {
        return messages?.count ?? 0
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func dataForCellAt(indexPath: IndexPath) -> ChatMessageModel? {
        return messages?[indexPath.row]
    }
    
    func didClickSend(message: String?) {
        guard let message = message else {
            return
        }
        insert(text: message, type: .sent)
        Chat(message: message + " " + message)
    }
}

private extension ChatVM {
    
    func insert(text: String?, type: ChatType) {
        let chatModel = ChatMessageModel(text: text, type: type)
        messages?.append(chatModel)
        saveInLocal(text: text, type: type)
        self.delegate?.loadNewChat(self)
    }
    
    func saveInLocal(text: String?, type: ChatType) {
        chatManager.saveChatMessage(for: id,
                                    name: name,
                                    chatMessage: ChatMessage(message: text, type: type))
    }
    
    func Chat(message: String?) {
        let chatModel = ChatMessageModel(text: message, type: .received)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.messages?.append(chatModel)
            weakSelf.saveInLocal(text: message, type: .received)
            weakSelf.delegate?.loadNewChat(weakSelf)
        }
    }
}
