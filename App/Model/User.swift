//
// Created by 王斌 on 05/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation

public struct User: Codable {

    public let id: Int
    public let login: String

    public init(id: Int, login: String) {
        self.id = id
        self.login = login
    }

}

extension User: Equatable {
}

public func ==(lhs: User, rhs: User) -> Bool {
    return lhs.id == rhs.id
}
