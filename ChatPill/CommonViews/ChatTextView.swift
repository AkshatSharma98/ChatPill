//
//  ChatTextView.swift
//  ChatPill
//
//  Created by Akshat Sharma on 17/01/22.
//

import Foundation
import UIKit

protocol ChatTextViewDelegate: AnyObject {
    func heightChanged(_ forClass: ChatTextView)
}

final class ChatTextView: UIView {
    
    ///MARK: Constants
    private let minHeight: CGFloat = 40
    private let maxHeight: CGFloat = 100
    
    ///MARK: Variables
    var delegate: ChatTextViewDelegate?
    private var textViewHeightConstraint: NSLayoutConstraint?
    
    ///MARK: UI
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 20)
        return textView
    }()
    
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.text = " Aa"
        label.textColor = Commons.getColorFromHex(hex: "#D7D7D7")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getText() -> String? {
        return textView.text
    }
    
    func setTextViewToNil() {
        textView.text = nil
        placeHolderLabel.isHidden = false
        textViewHeightConstraint?.constant = minHeight
        sendHeightUpdate()
    }
}

private extension ChatTextView {
    
    func createViews() {
        addViews()
        createContainerView()
        
        NSLayoutConstraint(item: textView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: containerView,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: textView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: containerView,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 12).isActive = true
        
        NSLayoutConstraint(item: textView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: containerView,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: -12).isActive = true
        
        NSLayoutConstraint(item: textView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: containerView,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: placeHolderLabel,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: textView,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: placeHolderLabel,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: textView,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        
        NSLayoutConstraint(item: placeHolderLabel,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: textView,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: placeHolderLabel,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: textView,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        
        textViewHeightConstraint = textView.heightAnchor.constraint(equalToConstant: minHeight)
        textViewHeightConstraint?.isActive = true
        
        containerView.layer.cornerRadius = 15
        textView.delegate = self
    }
    
    func addViews() {
        addSubview(containerView)
        containerView.addSubview(textView)
        containerView.addSubview(placeHolderLabel)
    }
    
    func createContainerView() {
        NSLayoutConstraint(item: containerView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: containerView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 0).isActive = true
        
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
    
    private func sendHeightUpdate() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.layoutIfNeeded()
        } completion: { [weak self] _ in
            guard let weakSelf = self else {
                return
            }
            weakSelf.delegate?.heightChanged(weakSelf)
        }
    }
}

extension ChatTextView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        placeHolderLabel.isHidden = !textView.text.isEmpty
        var height = minHeight
        
        if textView.contentSize.height <= minHeight {
            height = minHeight
        } else if textView.contentSize.height >= maxHeight {
            height = maxHeight
        } else {
            height = textView.contentSize.height
        }

        textViewHeightConstraint?.constant = height
        sendHeightUpdate()
    }
}
