//
//  HomePageVC.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation
import UIKit

//VC - ViewController
class HomePageVC: UIViewController {
    
    private var vm: HomePageVM?
    
    private let loaderView: LoaderView = {
        let loaderView = LoaderView()
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        return loaderView
    }()
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delaysContentTouches = false
        return tableView
    }()
    
    func addViews() {
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.addSubview(loaderView)
    }
    
    func hideLoaderView() {
        loaderView.isHidden = true
        loaderView.stopLoader()
    }
    
    func showLoader() {
        view.bringSubviewToFront(loaderView)
        loaderView.isHidden = false
        loaderView.startLoader()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
    }
    
    func registerCells() {
        tableView.register(UserChatTVC.self,
                           forCellReuseIdentifier: UserChatTVC.self.description())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        createViews()
        setupTableView()
        
        vm = HomePageVM(delegate: self)
        vm?.getUsers()
        view.backgroundColor = .white
        showLoader()
    }
    
    func createViews() {
        NSLayoutConstraint(item: headerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
//        NSLayoutConstraint(item: headerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: headerView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: headerView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        
        headerView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: loaderView, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: loaderView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: loaderView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: loaderView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    }
}

extension HomePageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?.numberOfRowsInSection(section: section) ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm?.numberOfSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserChatTVC.self.description(),
                                                 for: indexPath) as? UserChatTVC
        
        cell?.setData(chatModel: vm?.getDataModelFor(indexPath: indexPath))
        
        return cell ?? UITableViewCell()
    }
}

extension HomePageVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        let topVC = Commons.getTopVC()
        
        topVC?.navigationController?.pushViewController(ChatVC(), animated: true)
    }
}

extension HomePageVC: HomePageVMDelegate {
    
    func didFetchUsers() {
        hideLoaderView()
        tableView.reloadData()
    }
}