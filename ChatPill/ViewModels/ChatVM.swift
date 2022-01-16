//
//  ChatVM.swift
//  ChatPill
//
//  Created by Akshat Sharma on 16/01/22.
//

import Foundation

protocol ChatVMDelegate: AnyObject {
    func updateView()
}

class ChatVM {
    
    private var messages: [ChatMessageModel]?
    private var delegate: ChatVMDelegate?
    private var messageTime = 30
    
    init(delegate: ChatVMDelegate?) {
        self.delegate = delegate
        messages = [ChatMessageModel]()
    }
     
    func insert(text: String?, type: ChatType) {
        let chatModel = ChatMessageModel(text: text, type: type)
        messages?.append(chatModel)
        self.delegate?.updateView()
    }
    
    func Chat(message: String?) {
        let chatModel = ChatMessageModel(text: message, type: .received)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.messages?.append(chatModel)
            self?.delegate?.updateView()
        }
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
