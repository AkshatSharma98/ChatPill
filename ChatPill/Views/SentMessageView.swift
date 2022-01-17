//
//  MessageView.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation
import UIKit

class SentMessageView: UIView {
    
    ///MARK: Constants
    private let sizeRatio: CGFloat = 0.5
    private let imageName: String = "right_bubble"
    
    ///MARK: UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        createViews()
        setImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(text: String) {
        label.text = text
    }
    
}

private extension SentMessageView {
    
    func addViews() {
        addSubview(containerView)
        
        containerView.addSubview(imageView)
        containerView.addSubview(label)
    }
    
    func createViews() {
        
        NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        
        NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        
        NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        
        NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -30).isActive = true
        
        NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 12).isActive = true
        
        NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: -16).isActive = true
    }
    
    func setImage() {
        guard let image = UIImage(named: imageName) else {
            return
        }
        let w = image.size.width
        let h = image.size.height
        
        let top = sizeRatio * h
        let left = sizeRatio * w
        
        let resizableImage = image.resizableImage(withCapInsets:
                                                    UIEdgeInsets(top: top,
                                                                 left: left,
                                                                 bottom: top,
                                                                 right: left),
                                                  resizingMode: .stretch)
        imageView.image = resizableImage
    }
}

