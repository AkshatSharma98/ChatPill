//
//  UserChatTVC.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation
import UIKit

//TVC - Table View Cell

class UserChatTVC: UITableViewCell {
    
    private let imgSize: CGSize = CGSize(width: 50, height: 50)
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.2
        view.layer.cornerRadius = 4
        return view
    }()
    
    let imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        containerView.transform = .identity
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.1, animations:  {
            self.containerView.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        }, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.2, animations: {
            self.containerView.transform = .identity
        }, completion: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        createViews()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(chatModel: ChatModel?) {
        if let urlString = chatModel?.imgURL,
           let url = URL(string: urlString) {
            imgView.setImage(url: url)
        }
        
        titleLabel.text = "@" + (chatModel?.title ?? "")
    }
}

private extension UserChatTVC {
    
    func addViews() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(imgView)
        containerView.addSubview(titleLabel)
    }
    
    func createViews() {
        NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 12).isActive = true

        NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -12).isActive = true

        NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 12).isActive = true

        NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -12).isActive = true


        NSLayoutConstraint(item: imgView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true

        NSLayoutConstraint(item: imgView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 12).isActive = true

        NSLayoutConstraint(item: imgView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: containerView, attribute: .top, multiplier: 1, constant: 12).isActive = true

        NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: containerView, attribute: .bottom, multiplier: 1, constant: -12).isActive = true

        imgView.heightAnchor.constraint(equalToConstant: imgSize.height).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: imgSize.width).isActive = true



        NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true

        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: imgView, attribute: .trailing, multiplier: 1, constant: 12).isActive = true

        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: containerView, attribute: .top, multiplier: 1, constant: 12).isActive = true

        NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: containerView, attribute: .bottom, multiplier: 1, constant: -12).isActive = true

        NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -12).isActive = true
    }
}
