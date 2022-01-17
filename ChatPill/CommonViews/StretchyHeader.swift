//
//  StretchyHeader.swift
//  ChatPill
//
//  Created by Akshat Sharma on 16/01/22.
//

import Foundation
import UIKit

final class StretchyHeader: UIView {
    
    ///MARK: Private vars
    private var imageViewHeightConstraint: NSLayoutConstraint?
    
    ///MARK: UI
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "github")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        createViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewDidScrolled(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        imageViewHeightConstraint?.constant = -yOffset
    }
}
    
private extension StretchyHeader {
    
    func addViews() {
        addSubview(containerView)
        addSubview(imageView)
    }
    
    func createViews() {
        NSLayoutConstraint(item: containerView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: containerView,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .width,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: containerView,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .height,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: imageView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: containerView,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: imageView,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: containerView,
                           attribute: .width,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: imageView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: containerView,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        imageViewHeightConstraint = NSLayoutConstraint(item: imageView,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: containerView,
                                                       attribute: .height,
                                                       multiplier: 1,
                                                       constant: 0)
        
        imageViewHeightConstraint?.isActive = true
    }
}
