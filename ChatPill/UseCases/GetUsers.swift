//
//  GetUsers.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation

protocol GetUsersDelegate: AnyObject {
    func didFetchUsers(_ forClass: GetUsers, users: [User]?)
    func didFailToFetchUsers(_ forClass: GetUsers, message: String?)
}

final class GetUsers {
    
    private weak var delegate: GetUsersDelegate?
    private var getUsersRepo: GetUsersRepository?
    
    init(delegate: GetUsersDelegate) {
        self.delegate = delegate
        getUsersRepo = GetUsersRepository(delegate: self)
        getUsersRepo?.getUsers()
    }
}

extension GetUsers: GetUsersRepositoryDelegate {
    
    func didFetchUsers(_ forClass: GetUsersRepository, getUserData: GetUsersData?) {
        self.delegate?.didFetchUsers(self, users: getUserData?.users)
    }
    
    func didFailToFetchUsers(_ forClass: GetUsersRepository, getUserData: GetUsersData?) {
        self.delegate?.didFailToFetchUsers(self, message: getUserData?.message)
    }
}
