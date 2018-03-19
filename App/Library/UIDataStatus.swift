//
// Created by Yamazhiki on 19/03/2018.
// Copyright (c) 2018 ENT-LIVE. All rights reserved.
//

import Foundation

enum UIDataStatus<T> {
    case error(code: Int, msg: String, description: String)
    case result(data: T)
}
