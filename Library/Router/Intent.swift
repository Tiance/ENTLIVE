//
// Created by yamazhiki on 14/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation

class Intent {
    private var data: [String: Any] = [:]

    func setObject<T>(key: String, value: T) {
        data[key] = value
    }

    func getObject<T>(key: String) -> T? {
        return data[key] as? T
    }
}
