//
//  GithhubApiManager.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation

protocol GithubApiManagerDelegate: AnyObject {
    func didFetchUsers(_ forClass: GithubApiManager, response: GetUsersResponse?)
    func didFailToFetch(_ forClass: GithubApiManager, response: GetUsersResponse?)
}

final class GetUsersResponse: ResponseModel {
    let message: String?
    let users: [UsersDTO]?
    let statusCode: Int?
    
    init(message: String?, users: [UsersDTO]?, statusCode: Int?) {
        self.message = message
        self.users = users
        self.statusCode = statusCode
    }
}

final class GithubApiManager {
    
    ///MARK: Constants
    private let baseUrl = "https://api.github.com/"
    private let getUsersEndPoint = "users"
    
    ///MARK: Private Vars
    private weak var delegate: GithubApiManagerDelegate?
    private let sessionManager = URLSession(configuration: .default)
    
    init(with delegate: GithubApiManagerDelegate?) {
        self.delegate = delegate
    }
    
    func fetchUsers() {
        
        let userApiEndPoint = baseUrl + getUsersEndPoint
        
        guard let url = URL(string: userApiEndPoint) else {
            self.delegate?.didFailToFetch(self,
                                          response: GetUsersResponse(message: "Not a valid Api URL",
                                                                     users: nil,
                                                                     statusCode: nil))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = sessionManager.dataTask(with: urlRequest) { [weak self] data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                self?.didFailToFetchData(message: nil, statusCode: nil, users: nil)
                return
            }
            guard let data = data else {
                self?.didFailToFetchData(message: nil,
                                         statusCode: response.statusCode,
                                         users: nil)
                return
            }
            
            do {
                let users = try JSONDecoder().decode([UsersDTO].self, from: data)
                self?.didFetchData(message: nil, statusCode: response.statusCode, users: users)
            } catch {
                do {
                    let failureResponse = try JSONDecoder().decode(FailedResponse.self, from: data)
                    self?.didFetchData(message: failureResponse.message,
                                       statusCode: response.statusCode,
                                       users: nil)
                } catch {
                    self?.didFailToFetchData(message: error.localizedDescription,
                                             statusCode: response.statusCode,
                                             users: nil)
                }
            }
        }
        
        dataTask.resume()
    }
}

private extension GithubApiManager {
    
    struct FailedResponse: Decodable {
        let message: String?
    }
    
    func didFetchData(message: String?, statusCode: Int?, users: [UsersDTO]?) {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.delegate?.didFetchUsers(weakSelf,
                                             response: GetUsersResponse(message: message,
                                                                        users: users,
                                                                        statusCode: statusCode))
        }
    }
    
    func didFailToFetchData(message: String?, statusCode: Int?, users: [UsersDTO]?) {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.delegate?.didFailToFetch(weakSelf,
                                              response: GetUsersResponse(message: message,
                                                                         users: users,
                                                                         statusCode: statusCode))
        }
    }
}
