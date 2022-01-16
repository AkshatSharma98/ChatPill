//
//  GithhubApiManager.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation

protocol GithubApiManagerDelegate: AnyObject {
    func didFetchUsers(users: [UsersDTO]?)
}

class GithubApiManager {
    
    private let baseUrl = "https://api.github.com/"
    private let getUsersEndPoint = "users"
    
    private weak var delegate: GithubApiManagerDelegate?
    
    private let sessionManager = URLSession(configuration: .default)
    
    
    init(with delegate: GithubApiManagerDelegate?) {
        self.delegate = delegate
    }
    
    func fetchUsers() {
        
        let userApiEndPoint = baseUrl + getUsersEndPoint
        
        guard let url = URL(string: userApiEndPoint) else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = sessionManager.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == Constants.successStatusCode,
                  let data = data
            else {
                return
            }
            
            do {
                let users = try JSONDecoder().decode([UsersDTO].self, from: data)
                
                DispatchQueue.main.async {
                    self.delegate?.didFetchUsers(users: users)
                }
                
                
                print(users)
            } catch {
                print("error while decoding")
            }
        }
        
        dataTask.resume()
    }
}
