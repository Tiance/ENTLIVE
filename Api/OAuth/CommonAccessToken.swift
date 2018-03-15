//
// Created by yamazhiki on 09/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation

public class CommonAccessToken: OauthAccessTokenType {
    public let token: String
    public private(set) var key: String = "token"
    public var value: String {
        return token
    }

    public init(token: String) {
        self.token = token
    }
}