//
//  TestCDVC.swift
//  ChatPill
//
//  Created by Akshat Sharma on 16/01/22.
//

import Foundation
import UIKit

class TestCDVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       // createChatMessage()
        
        fetchChat()
    }
    
    func createChatMessage() {
        
        let chatMessage = CDChat(context: PersistentStorage.shared.context)
        
        chatMessage.name = "akshat"
        
        PersistentStorage.shared.saveContext()
        
    }
    
    func fetchChat() {
        do {
            let result = try PersistentStorage.shared.context.fetch(CDChat.fetchRequest())
            
            result.forEach { value in
                print(value)
            }
            
        } catch {
            
        }
        
    }
}
