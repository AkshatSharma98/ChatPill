//
//  HomePageVM.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation

protocol HomePageVMDelegate: AnyObject {
    func didFetchUsers(_ forClass: HomePageVM)
    func didFailToFetch(_ forClass: HomePageVM, message: String?)
}

final class HomePageVM {
    
    private var getUser: GetUsers?
    private weak var delegate: HomePageVMDelegate?
    private var users: [User]?
    
    init(delegate: HomePageVMDelegate?) {
        self.delegate = delegate
    }
    
    func vmDidLoad() {
        getUsers()
    }
    
    func getData() {
        getUsers()
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
    
    private func getUsers() {
        getUser = GetUsers(delegate: self)
    }
}

///MARK: GetUsersDelegate
extension HomePageVM: GetUsersDelegate {
    
    func didFetchUsers(_ forClass: GetUsers, users: [User]?) {
        self.users = users
        self.delegate?.didFetchUsers(self)
    }
    
    func didFailToFetchUsers(_ forClass: GetUsers, message: String?) {
        self.delegate?.didFailToFetch(self, message: message)
    }
}
