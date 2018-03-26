//
// Created by Yamazhiki on 16/03/2018.
// Copyright (c) 2018 ENT-LIVE. All rights reserved.
// App 与 服务端接口定义
//

import Foundation
import Moya

enum Client {

    case users
    case singleUser(id: Int)
    case detail(id: Int)

    public var path: String {
        switch self {
        case .users: return "users"
        case .singleUser(let id):return "user/\(id)"
        case .detail(let id): return "detail/\(id)"
        }
    }
    public var method: Moya.Method {
        return .get
    }
}
