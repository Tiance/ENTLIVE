//
//  Message.swift
//  ENTLIVE
//
//  Created by 姜楠 on 2018/3/27.
//  Copyright © 2018年 斌王. All rights reserved.
//

import UIKit
import RxDataSources

enum MessageType {
    case common
    case share
    case praise
}

struct RoomMessage {
    var items: [Message]
}

extension RoomMessage: SectionModelType {
    typealias Item = Message

    init(original: RoomMessage, items: [Message]) {
        self.items = items
        self = original
    }
}
struct Message {
    let type: MessageType
    let name: String
    let content: String
    var color: UIColor
}
