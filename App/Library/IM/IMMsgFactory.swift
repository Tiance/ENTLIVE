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
    case custom
}


struct IMMsgFactory {
    static func textMsg<T>(type: IMSDK = IMSDK.tencent,
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

    static func imageMsg<T>(type: IMSDK = IMSDK.tencent,
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

    static func customMsg<T>(type: IMSDK = IMSDK.tencent,
                             message: IMMessage) -> T {
        switch type {
        case .tencent:
            let msg = TIMMessage()
            let el = TIMCustomElem()
            el.data = try! AppEnvironment.current.encoder.encode(message)
            msg.add(el)
            return msg as! T
        }
    }

}
