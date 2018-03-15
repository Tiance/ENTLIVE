//
// Created by yamazhiki on 13/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import UIKit

enum IMSDK {
    case tencent
}

enum IMMsgType {
    case text
    case image
    case location
}


struct IMMsgFactory {
    static func textMessage<T>(type: IMSDK = IMSDK.tencent,
                               text: String = "") -> T {
        switch type {
        case .tencent:
            let msg = TIMMessage()
            let el = TIMTextElem()
            el.text = text
            msg.add(el)
            return msg as! T

        }

    }

    static func createImgMsg<T>(type: IMSDK = IMSDK.tencent,
                                path: String = "") -> T {
        switch type {
        case .tencent:
            let msg = TIMMessage()
            let el = TIMImageElem()
            el.path = ""
            msg.add(el)
            return msg as! T

        }
    }

}
