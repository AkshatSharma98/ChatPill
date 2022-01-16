//
//  HomePageVM.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation

protocol HomePageVMDelegate: AnyObject {
    func didFetchUsers()
}

class HomePageVM {
    
    private var getUser: GetUsers?
    private weak var delegate: HomePageVMDelegate?
    private var users: [User]?
    
    init(delegate: HomePageVMDelegate?) {
        self.delegate = delegate
    }
    
    func getUsers() {
        getUser = GetUsers(delegate: self)
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func getDataModelFor(indexPath: IndexPath) -> ChatModel? {
        return ChatModel(imgURL: users?[indexPath.row].imgUrl,
                         title: users?[indexPath.row].name)
    }
}

extension HomePageVM: GetUsersDelegate {
    func didFetchUsers(users: [User]?) {
        self.users = users
        self.delegate?.didFetchUsers()
    }
}
