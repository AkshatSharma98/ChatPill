//
//  MessageView.swift
//  ChatPill
//
//  Created by Akshat Sharma on 18/01/22.
//

import Foundation
import UIKit

class MessageView: UIView {
    
    ///MARK: Constants
    let sizeRatio: CGFloat = 0.5
    
    ///MARK: UI Components
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.white
        return label
    }()
    
    init(imageName: String) {
        super.init(frame: .zero)
        addViews()
        createViews()
        setImage(imageName: imageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews() {} //to be override
    
    func setData(text: String) {
        label.text = text
    }
    
}

private extension MessageView {
    
    func addViews() {
        addSubview(containerView)
        
        containerView.addSubview(imageView)
        containerView.addSubview(label)
    }
    
    func setImage(imageName: String) {
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
