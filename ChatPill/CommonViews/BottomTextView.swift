//
//  BottomTextView.swift
//  ChatPill
//
//  Created by Akshat Sharma on 14/01/22.
//

import Foundation
import UIKit

protocol BottomTextViewDelegate: AnyObject {
    func didClickSendButton(_ forClass: BottomTextView, text: String)
    func updateInsetIfNeeded(_ forClass: BottomTextView, height: CGFloat)
}

final class BottomTextView: UIView {
    
    ///MARK: Private Vars + Constants
    private weak var delegate: BottomTextViewDelegate?
    private var bottomConstraint: NSLayoutConstraint?
    
    //MARK: UI
    let containerView: UIView = {
        let view  = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let textViewContainer: ChatTextView = {
        let view = ChatTextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(Commons.getColorFromHex(hex: "#347aeb"), for: .normal)
        return button
    }()
    
    init(delegate: BottomTextViewDelegate?) {
        super.init(frame: .zero)
        self.delegate = delegate
        createViews()
        self.backgroundColor = Commons.getColorFromHex(hex: "#D7D7D7")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateHeightConstraint(newValue: CGFloat) {
        bottomConstraint?.constant = newValue
    }
    
    @objc func didClickSend() {
        let text = textViewContainer.getText()
        guard let textUnwrapped = text, !textUnwrapped.isEmpty else {
            return
        }
        self.delegate?.didClickSendButton(self, text: textUnwrapped)
    }
    
    func setTextViewToNil() {
        textViewContainer.setTextViewToNil()
    }
}

private extension BottomTextView {
    
    func setupViews() {
        sendButton.addTarget(self, action: #selector(didClickSend), for: .touchUpInside)
        sendButton.setTitle("Send", for: .normal)
        textViewContainer.delegate = self
    }
    
    func addViews() {
        addSubview(containerView)
        containerView.addSubview(textViewContainer)
        containerView.addSubview(sendButton)
    }
    
    func createContainerView() {
        NSLayoutConstraint(item: containerView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        bottomConstraint = NSLayoutConstraint(item: containerView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: -Commons.getNotchHeight())
        bottomConstraint?.isActive = true
        
        NSLayoutConstraint(item: containerView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: containerView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: 0).isActive = true
    }

    func createViews() {
        addViews()
        setupViews()
        
        createContainerView()
        
        sendButton.setContentHuggingPriority(.required, for: .horizontal)
        sendButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        NSLayoutConstraint(item: sendButton,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: containerView,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: -12).isActive = true
        
        NSLayoutConstraint(item: sendButton,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: containerView,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: -16).isActive = true
        
        NSLayoutConstraint(item: textViewContainer,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: containerView,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 12).isActive = true
        
        NSLayoutConstraint(item: textViewContainer,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: sendButton,
                           attribute: .leading,
                           multiplier: 1,
                           constant: -12).isActive = true
        
        NSLayoutConstraint(item: textViewContainer,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: containerView,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: -12).isActive = true
        
        NSLayoutConstraint(item: textViewContainer,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: containerView,
                           attribute: .top,
                           multiplier: 1,
                           constant: 12).isActive = true
        
        containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
    }
}

extension BottomTextView: ChatTextViewDelegate {
    
    func heightChanged(_ forClass: ChatTextView) {
        self.delegate?.updateInsetIfNeeded(self, height: self.containerView.frame.height)
    }
}
