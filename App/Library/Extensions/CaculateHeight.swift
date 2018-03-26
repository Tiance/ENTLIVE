//
//  CaculateHeight.swift
//  ENTLIVE
//
//  Created by 姜楠 on 2018/3/25.
//  Copyright © 2018年 斌王. All rights reserved.
//

import UIKit

//计算描述的高度
func caculateContentHeight(contentString: NSString, maxWidth: CGFloat, fontSize: CGFloat, lineSpacing: CGFloat) -> CGSize {
    
    if contentString.length > 0 {
        let paragrapghStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragrapghStyle.lineSpacing = lineSpacing
        let contentSize: CGSize = contentString.boundingRect(with: CGSize.init(
            width: maxWidth,
            height: CGFloat(MAXFLOAT)),
                                                             options: [NSStringDrawingOptions.usesFontLeading, NSStringDrawingOptions.truncatesLastVisibleLine, NSStringDrawingOptions.usesLineFragmentOrigin],
                                                             attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize), NSAttributedStringKey.paragraphStyle: paragrapghStyle], context: nil).size
        return contentSize
    }
    return CGSize.init(width: lineSpacing, height: UIFont.systemFont(ofSize: fontSize).lineHeight)
}

