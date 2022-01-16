//
//  ChatVC.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation
import UIKit

class ChatVC: UIViewController {
    
    private var tableViewBottomConstraint: NSLayoutConstraint?
    private var isKeyboardVisible: Bool = false
    private var vm: ChatVM?
    private let name: String
    
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
        return tableView
    }()
    
    private lazy var bottomTextView: BottomTextView = {
        let view = BottomTextView(delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        createViews()
        setupTableView()
        registerForKeyboardNotifications()
        view.backgroundColor = .white
        vm = ChatVM(delegate: self, name: name, id: name)
        self.title = "@\(name)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        scrollToBottom()
    }
    
    init(name: String) {
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollToBottom(animated: Bool = false) {
        DispatchQueue.main.async { [weak self] in
            guard let count =  self?.vm?.numberOfRows(), count - 1 >= 0 else {
                return
            }
            let indexPath = IndexPath(row: count - 1, section: 0)
            self?.tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
        }
    }
    
    override func viewDidLayoutSubviews() {
        if isKeyboardVisible == false {
            let height = bottomTextView.frame.height
            tableView.contentInset.bottom = height
        } else {
            tableView.contentInset.bottom = bottomTextView.containerView.frame.height + Commons.getNotchHeight()
        }
    }
}

private extension ChatVC {
    
    func addViews() {
        view.addSubview(tableView)
        view.addSubview(bottomTextView)
    }
    
    private func createViews() {
        
        NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 100).isActive = true
        
        NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 12).isActive = true
        
        NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -12).isActive = true
        
        tableViewBottomConstraint = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        tableViewBottomConstraint?.isActive = true
        
        NSLayoutConstraint(item: bottomTextView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: bottomTextView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: bottomTextView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
    }
    
    func registerCells() {
        tableView.register(ReceivedMessageTVC.self,
                           forCellReuseIdentifier: ReceivedMessageTVC.self.description())
        
        tableView.register(SentMessageTVC.self,
                           forCellReuseIdentifier: SentMessageTVC.self.description())
    }
    
    @objc
    func keyboardWillShowNotification(_ notification: NSNotification) {
        isKeyboardVisible = true
        if let userInfo = notification.userInfo {
            let keyboardFrame =  (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let keyboardHeight = keyboardFrame.height
            
            tableViewBottomConstraint?.constant = -(bottomTextView.containerView.frame.height + keyboardHeight - 3 * Commons.getNotchHeight())
            self.bottomTextView.updateHeightConstraint(height: -keyboardHeight)
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
              //
                self?.view.layoutIfNeeded()
            }, completion: { [weak self] _ in
                self?.scrollToBottom(animated: true)
            })
        }
    }
    
    @objc
    func keyboardWillHideNotification(_ notification: NSNotification) {
        isKeyboardVisible = false
        tableViewBottomConstraint?.constant = 0
        self.bottomTextView.updateHeightConstraint(height: -Commons.getNotchHeight())
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func registerForKeyboardNotifications() {
        let notifier = NotificationCenter.default
        notifier.addObserver(self,
                             selector: #selector(keyboardWillShowNotification(_:)),
                             name: UIWindow.keyboardWillShowNotification,
                             object: nil)
        notifier.addObserver(self,
                             selector: #selector(keyboardWillHideNotification(_:)),
                             name: UIWindow.keyboardWillHideNotification,
                             object: nil)
    }
}

extension ChatVC: UITableViewDelegate {
}

extension ChatVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?.numberOfRows() ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let chatModel = vm?.dataForCellAt(indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        switch chatModel.type {
        case .received:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReceivedMessageTVC.self.description(), for: indexPath) as? ReceivedMessageTVC
            cell?.setData(message: chatModel.text ?? "")
            return cell ?? UITableViewCell()
            
        case .sent:
            let cell = tableView.dequeueReusableCell(withIdentifier: SentMessageTVC.self.description(), for: indexPath) as? SentMessageTVC
            cell?.setData(message: chatModel.text ?? "")
            return cell ?? UITableViewCell()
        }
    }
}

extension ChatVC: ChatVMDelegate {
    func updateView() {
        tableView.reloadData()
        scrollToBottom()
    }
}

extension ChatVC: BottomTextViewDelegate {
    func layoutNeeded() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.view.layoutIfNeeded()
            self?.scrollToBottom()
        }, completion: nil)
    }
    
    func didClickSendButton(text: String) {
        bottomTextView.setTextViewToNil()
        vm?.didClickSend(message: text)
    }
}
