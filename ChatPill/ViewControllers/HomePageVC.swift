//
//  HomePageVC.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation
import UIKit

final class HomePageVC: UIViewController {
    
    ///MARK: ViewModel
    private var vm: HomePageVM?
    
    ///MARK: UI Components
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
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 0
        tableView.sectionHeaderHeight = 0
        tableView.estimatedRowHeight = 44
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset.bottom = Commons.getNotchHeight()
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        createViews()
        setupTableView()
        loaderView.delegate = self
        
        vm = HomePageVM(delegate: self)
        vm?.vmDidLoad()
        
        view.backgroundColor = .white
        showLoader(message: "Welcome To GitHub Chat")
    }
    
}

private extension HomePageVC {
    
    func addViews() {
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.addSubview(loaderView)
    }
    
    func createViews() {
        NSLayoutConstraint(item: headerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
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
        
        tableView.tableHeaderView = StretchyHeader()
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: 0, height: 300)
    }
    
    func hideLoaderView() {
        loaderView.isHidden = true
        loaderView.stopLoader()
    }
    
    func showLoader(message: String? = nil) {
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
}

///MARK: UITableViewDataSource
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

///MARK: UITableViewDelegate
extension HomePageVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        let topVC = Commons.getTopVC()
        
        let data = vm?.getDataModelFor(indexPath: indexPath)
        
        if let name = data?.title {
            topVC?.navigationController?.pushViewController(ChatVC(name: name), animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let header = tableView.tableHeaderView as? StretchyHeader
        header?.viewDidScrolled(scrollView)
    }

}

///MARK: HomePageVMDelegate
extension HomePageVC: HomePageVMDelegate {
    func didFetchUsers(_ forClass: HomePageVM) {
        hideLoaderView()
        tableView.reloadData()
    }
    
    func didFailToFetch(_ forClass: HomePageVM, message: String?) {
        view.bringSubviewToFront(loaderView)
        loaderView.setMessage(text: message,
                              shouldHideLoader: true,
                              showRetryButton: true)
    }
}

///MARK: LoaderViewDelegate
extension HomePageVC: LoaderViewDelegate {
    
    func didClickRetryButton(_ forClass: LoaderView) {
        showLoader()
        vm?.getData()
    }
}
