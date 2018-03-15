//
// Created by yamazhiki on 09/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation

public class BearerAccessToken: OauthAccessTokenType {
    let token: String

    public var value: String {
        return ""
    }
    public var key: String {
        return "Bearer "
    }

    public init(token: String) {
        self.token = token
    }
}
