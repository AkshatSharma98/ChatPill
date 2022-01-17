//
//  BottomTextView.swift
//  ChatPill
//
//  Created by Akshat Sharma on 14/01/22.
//

import Foundation
import UIKit

protocol BottomTextViewDelegate: AnyObject {
    func didClickSendButton(text: String)
    func layoutNeeded()
}

class BottomTextView: UIView {
    
    private weak var delegate: BottomTextViewDelegate?
    private var bottomConstraint: NSLayoutConstraint?
    private var textViewHeightConstraint: NSLayoutConstraint?
    private let minHeight: CGFloat = 40
    private let maxHeight: CGFloat = 100
    
    let containerView: UIView = {
        let view  = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let textViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(Commons.getColorFromHex(hex: "#15186F"), for: .normal)
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
    
    func updateHeightConstraint(height: CGFloat) {
        bottomConstraint?.constant = height
    }
    
    @objc func didClickSend() {
        let text = textView.text
        guard let textUnwrapped = text, textUnwrapped.isEmpty == false else {
            return
        }
        self.delegate?.didClickSendButton(text: textUnwrapped)
    }
    
    func setTextViewToNil() {
        textView.text = nil
        textViewHeightConstraint?.constant = minHeight
        self.delegate?.layoutNeeded()
    }
}

private extension BottomTextView {
    
    func setupViews() {
        sendButton.addTarget(self, action: #selector(didClickSend), for: .touchUpInside)
    }
    
    func addViews() {
        addSubview(containerView)
        
        containerView.addSubview(textViewContainer)
        containerView.addSubview(sendButton)
        textViewContainer.addSubview(textView)
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
    
    func createTextField() {
        
        NSLayoutConstraint(item: textView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: textViewContainer,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: textView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: textViewContainer,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 12).isActive = true
        
        
        NSLayoutConstraint(item: textView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: textViewContainer,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: -12).isActive = true
        
        NSLayoutConstraint(item: textView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: textViewContainer,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        textViewHeightConstraint = textView.heightAnchor.constraint(equalToConstant: minHeight)
        textViewHeightConstraint?.isActive = true
        
        textViewContainer.layer.cornerRadius = 15
        sendButton.setTitle("Send", for: .normal)
        textView.delegate = self
    }
    

    func createViews() {
        addViews()
        setupViews()
        
        createContainerView()
        createTextField()
        
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

extension BottomTextView: UITextViewDelegate {
    
    // hides text views
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    // hides text fields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        var height = minHeight
        
        if textView.contentSize.height <= minHeight {
            height = minHeight
        } else if textView.contentSize.height >= maxHeight {
            height = maxHeight
        } else {
            height = textView.contentSize.height
        }

        textViewHeightConstraint?.constant = height
        UIView.animate(withDuration: 0.1, animations:  { [weak self] in
            self?.layoutIfNeeded()
        }) { [weak self] _ in
            self?.delegate?.layoutNeeded()
        }
    }
}
