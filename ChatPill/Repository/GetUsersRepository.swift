//
//  GetUsersRepository.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation

protocol GetUsersRepositoryDelegate: AnyObject {
    func didFetchUsers(_ forClass: GetUsersRepository, getUserData: GetUsersData?)
    func didFailToFetchUsers(_ forClass: GetUsersRepository, getUserData: GetUsersData?)
}

final class GetUsersData: ResponseModel {
    let statusCode: Int?
    let message: String?
    let users: [User]?
    
    init(statusCode: Int?, message: String?, users: [User]?) {
        self.statusCode = statusCode
        self.message = message
        self.users = users
    }
}

final class GetUsersRepository {
   
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
    func didFetchUsers(_ forClass: GithubApiManager, response: GetUsersResponse?) {
        if response?.statusCode != Constants.successStatusCode {
            handleFailure(response: response)
        }
        self.delegate?.didFetchUsers(self, getUserData: GetUsersData(statusCode: response?.statusCode,
                                                               message: response?.message,
                                                               users: getUsersArray(from: response?.users)))
    }
    
    func didFailToFetch(_ forClass: GithubApiManager, response: GetUsersResponse?) {
        handleFailure(response: response)
    }
}

private extension GetUsersRepository {
    
    func getUsersArray(from usersDTO: [UsersDTO]?) -> [User]? {
        guard let usersDTOUnwrapped = usersDTO, usersDTOUnwrapped.count > 0 else {
            return nil
        }
        var usersLocal = [User]()
        usersDTOUnwrapped.forEach({ userDTO in
            let user = User(name: userDTO.userName, imgUrl: userDTO.profileImgUrl)
            usersLocal.append(user)
        })
        return usersLocal
    }
    
    func handleFailure(response: GetUsersResponse?) {
        self.delegate?.didFailToFetchUsers(self, getUserData: GetUsersData(statusCode: response?.statusCode,
                                                                     message: response?.message,
                                                                     users: getUsersArray(from: response?.users)))
    }
}
