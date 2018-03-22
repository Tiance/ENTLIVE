//
// Created by yamazhiki on 07/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import Prelude

extension User {
    enum lens {
        public static let login = Lens<User, String>(
                view: { $0.login },
                set: { User(id: $1.id, login: $0) }
        )

        public static let id = Lens<User, Int>(view: { $0.id }, set: { User(id: $0, login: $1.login) })
    }
}
