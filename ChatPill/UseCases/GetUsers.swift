//
//  GetUsers.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation

protocol GetUsersDelegate: AnyObject {
    func didFetchUsers(users: [User]?)
    func didFailToFetchUsers(message: String?)
}

class GetUsers {
    
    private weak var delegate: GetUsersDelegate?
    private var getUsersRepo: GetUsersRepository?
    
    init(delegate: GetUsersDelegate) {
        self.delegate = delegate
        getUsersRepo = GetUsersRepository(delegate: self)
        getUsersRepo?.getUsers()
    }
}

extension GetUsers: GetUsersRepositoryDelegate {
    func didFetchUsers(getUserData: GetUsersData?) {
        self.delegate?.didFetchUsers(users: getUserData?.users)
    }
    
    func didFailToFetchUsers(getUserData: GetUsersData?) {
        self.delegate?.didFailToFetchUsers(message: getUserData?.message)
    }
}
