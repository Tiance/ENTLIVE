//
// Created by yamazhiki on 15/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation

enum IMCmd: Int, Codable {
    case none
}

enum IMCommandType: Int, Codable {
    case none
}

struct IMMessage: Codable {
    let cmd: IMCmd
    let cmdType: IMCommandType
}