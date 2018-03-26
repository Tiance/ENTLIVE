//
// Created by yamazhiki on 09/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation

public class JWTTokenAccess: OauthAccessTokenType {
    public let token: String
    public private(set) var key: String = ""
    public private(set) var value: String = ""

    public init(token: String) {
        self.token = token
    }
}
