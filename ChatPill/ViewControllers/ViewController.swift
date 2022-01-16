//
//  ViewController.swift
//  ChatPill
//
//  Created by Akshat Sharma on 14/01/22.
//

import UIKit

class ViewController: UIViewController {
    
   // private var bottomConstraint: NSLayoutConstraint?
    
    let messageView: SentMessageView = {
        let view = SentMessageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bottomTextView: BottomTextView = {
        let view = BottomTextView(delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createViews()
        registerForKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications() {
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
    
    @objc
    func keyboardWillShowNotification(_ notification: NSNotification) {
        if let userInfo = notification.userInfo {
            
            let keyboardFrame =  (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            self.bottomTextView.updateHeightConstraint(height: -keyboardFrame.height)
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc
    func keyboardWillHideNotification(_ notification: NSNotification) {
        self.bottomTextView.updateHeightConstraint(height: -Commons.getNotchHeight())
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func createViews() {
        view.addSubview(bottomTextView)
        view.addSubview(messageView)
        
        NSLayoutConstraint(item: bottomTextView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: bottomTextView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: bottomTextView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: messageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 150).isActive = true
        
        NSLayoutConstraint(item: messageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 12).isActive = true
        
        NSLayoutConstraint(item: messageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -12).isActive = true
        
       // .heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

extension ViewController: BottomTextViewDelegate {
    func didClickSendButton(text: String) {
        
    }
    
    
}
