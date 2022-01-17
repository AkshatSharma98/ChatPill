//
//  LoaderView.swift
//  ChatPill
//
//  Created by Akshat Sharma on 16/01/22.
//

import Foundation
import UIKit

final class LoaderView: UIView {
    
    ///MARK: UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = Commons.getColorFromHex(hex: "#5c6160")
        label.textAlignment = .center
        return label
    }()
    
    private let loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        createViews()
        loader.startAnimating()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoader() {
        loader.isHidden = false
        loader.startAnimating()
    }
    
    func stopLoader() {
        loader.isHidden = true
        loader.stopAnimating()
    }
    
    func setMessage(text: String?, shouldHideLoader: Bool) {
        messageLabel.text = text
        shouldHideLoader ? stopLoader() : startLoader()
    }
}

private extension LoaderView {
    
    func addViews() {
        addSubview(containerView)
        containerView.addSubview(loader)
        containerView.addSubview(messageLabel)
    }
    
    func createViews() {
        NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: loader, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: loader, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: messageLabel, attribute: .bottom, relatedBy: .equal, toItem: loader, attribute: .top, multiplier: 1, constant: -12).isActive = true
        
        NSLayoutConstraint(item: messageLabel, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 12).isActive = true
        
        NSLayoutConstraint(item: messageLabel, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -12).isActive = true
    }
}
