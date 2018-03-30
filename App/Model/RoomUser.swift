//
//  RoomUser.swift
//  ENTLIVE
//
//  Created by 姜楠 on 2018/3/27.
//  Copyright © 2018年 斌王. All rights reserved.
//

import UIKit
import RxDataSources

struct RoomUserSection {
    var items: [RoomUser]
}

extension RoomUserSection: SectionModelType {
    typealias Item = RoomUser

    init(original: RoomUserSection, items: [RoomUser]) {
        self.items = items
        self = original
    }
}

struct RoomUser {
    let name: String
    let image: UIImage
    let id: Int
}
