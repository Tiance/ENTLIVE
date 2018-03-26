//
//  Item.swift
//  ENTLIVE
//
//  Created by 姜楠 on 2018/3/21.
//  Copyright © 2018年 斌王. All rights reserved.
//

import UIKit
import RxDataSources

struct ItemData {
    var items: [Home2Item]
}

extension ItemData: SectionModelType {
    typealias Item = Home2Item
    
    init(original: ItemData, items: [Home2Item]) {
        self.items = items
        self = original
    }
}

public struct Home2Item {
    var name: String = "麦小兜&"
    var image: String = ""
    var fans: Int = 3231
}

