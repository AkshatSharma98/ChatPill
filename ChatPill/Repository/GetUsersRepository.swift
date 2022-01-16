//
//  GetUsersRepository.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation


protocol GetUsersRepositoryDelegate: AnyObject {
    func didFetchUsers(users: [User]?)
}

class GetUsersRepository {
   
    lazy var apiManager: GithubApiManager = GithubApiManager(with: self)
    private weak var delegate: GetUsersRepositoryDelegate?
    
    init(delegate: GetUsersRepositoryDelegate?) {
        self.delegate = delegate
    }
    
    func getUsers() {
        apiManager.fetchUsers()
    }
}

extension GetUsersRepository: GithubApiManagerDelegate {
    
    func didFetchUsers(users: [UsersDTO]?) {
        var usersLocal = [User]()
        users?.forEach({ userDTO in
            let user = User(name: userDTO.userName, imgUrl: userDTO.profileImgUrl)
            usersLocal.append(user)
        })
        
        self.delegate?.didFetchUsers(users: usersLocal)
    }
}
