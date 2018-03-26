//
//  RoomChatCell.swift
//  ENTLIVE
//
//  Created by 姜楠 on 2018/3/26.
//  Copyright © 2018年 斌王. All rights reserved.
//

import UIKit

class RoomChatCell: UICollectionViewCell {
    
    private let chatBGView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage.init(named: "charBG.jpeg"))
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8.0
        imageView.alpha = 0.6
        return imageView
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        label.backgroundColor = .clear
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.preferredMaxLayoutWidth = 1
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize.init(width: 0.7, height: 0.7)
        return label
    }()
    
    var model: Message! {
        didSet {
            let str = NSMutableAttributedString.init(string: model.content)
            str.addAttribute(NSAttributedStringKey.foregroundColor, value: self.model.color, range: NSMakeRange(self.model.name.count, model.content.utf16.count - self.model.name.count))
            contentLabel.attributedText = str
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(chatBGView)
        contentView.addSubview(contentLabel)
        
        NSLayoutConstraint(item: chatBGView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: contentView,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: chatBGView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: contentView,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: 3).isActive = true
        NSLayoutConstraint(item: contentView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: chatBGView,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: contentView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: chatBGView,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: 3).isActive = true
        contentLabel.frame = chatBGView.bounds
    }
    
    func setupUI() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
