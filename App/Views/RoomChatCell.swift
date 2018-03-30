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
        let imageView = UIImageView.init(image: UIImage.init(named: "chatBG.jpeg"))
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
            let str = NSMutableAttributedString.init(string: "\(model.name):\(model.content)")
            str.addAttribute(NSAttributedStringKey.foregroundColor, value: self.model.color, range: NSMakeRange(self.model.name.count+1, model.content.count))
            contentLabel.attributedText = str
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(chatBGView)
        contentView.addSubview(contentLabel)

        chatBGView.frame = contentView.bounds
        contentLabel.frame = chatBGView.bounds
    }

    func setupUI() {

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RoomChatCell {
    class func summaryCellHeight(model: Message) -> CGFloat {
        let textSize: CGSize = caculateContentHeight(contentString: model.content+model.name as NSString, maxWidth: UIScreen.main.bounds.size.width, fontSize: 17, lineSpacing: 0)

        return 4 + textSize.height
    }
}
