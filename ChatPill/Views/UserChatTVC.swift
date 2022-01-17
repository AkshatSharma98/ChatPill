//
//  UserChatTVC.swift
//  ChatPill
//
//  Created by Akshat Sharma on 15/01/22.
//

import Foundation
import UIKit

//TVC - Table View Cell
final class UserChatTVC: UITableViewCell {
    
    ///MARK: Constants
    private let imgSize: CGSize = CGSize(width: 50, height: 50)
    private let rightIconSize: CGSize = CGSize(width: 10, height: 20)
    private let scaleDownRatio: CGFloat = 0.96
    private let touchDownDuration = 0.1
    private let touchUpDuration = 0.2
    
    ///MARK: UI Components
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
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = nil
        titleLabel.text = nil
        containerView.transform = .identity
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: touchDownDuration, animations:  { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.containerView.transform = CGAffineTransform(scaleX: weakSelf.scaleDownRatio,
                                                                 y: weakSelf.scaleDownRatio)
        }, completion: nil)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: touchUpDuration, animations: { [weak self] in
            self?.containerView.transform = .identity
        }, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.containerView.transform = .identity
        }, completion: nil)
    }
    
    private let rightIconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = Commons.getColorFromHex(hex: "#D7D7D7")
        return view
    }()
    
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
        containerView.addSubview(rightIconView)
    }
    
    func createViews() {
        //containerView
        NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 12).isActive = true

        NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -12).isActive = true

        NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 12).isActive = true

        NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -12).isActive = true

        //imgView
        NSLayoutConstraint(item: imgView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true

        NSLayoutConstraint(item: imgView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 12).isActive = true

        NSLayoutConstraint(item: imgView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: containerView, attribute: .top, multiplier: 1, constant: 12).isActive = true

        imgView.heightAnchor.constraint(equalToConstant: imgSize.height).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: imgSize.width).isActive = true

        //title label
        NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true

        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: imgView, attribute: .trailing, multiplier: 1, constant: 12).isActive = true

        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: containerView, attribute: .top, multiplier: 1, constant: 12).isActive = true

        NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: containerView, attribute: .bottom, multiplier: 1, constant: -12).isActive = true

        NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: rightIconView, attribute: .leading, multiplier: 1, constant: -12).isActive = true
        
        
        //right icon view
        NSLayoutConstraint(item: rightIconView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true

        NSLayoutConstraint(item: rightIconView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -12).isActive = true

        NSLayoutConstraint(item: rightIconView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: containerView, attribute: .top, multiplier: 1, constant: 12).isActive = true
        
        NSLayoutConstraint(item: rightIconView, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: containerView, attribute: .bottom, multiplier: 1, constant: -12).isActive = true
        
        rightIconView.heightAnchor.constraint(equalToConstant: rightIconSize.height).isActive = true
        rightIconView.widthAnchor.constraint(equalToConstant: rightIconSize.width).isActive = true
    }
}
