//
//  ChatModel.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation

final class ChatModel {
    let imgURL: String?
    let title: String?
    
    init(imgURL: String?, title: String?) {
        self.imgURL = imgURL
        self.title = title
    }
}
