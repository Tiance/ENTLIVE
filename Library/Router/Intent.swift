//
// Created by yamazhiki on 14/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation

@objc class Intent: NSObject {
    let data: [String: Any]

    init(data: [String: Any] = [:]) {
        self.data = data
    }
}
