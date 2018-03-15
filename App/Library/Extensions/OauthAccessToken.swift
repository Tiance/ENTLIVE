//
// Created by yamazhiki on 15/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import Api

enum AccessTokenType: Int {
    case common
    case bearer
    case jwt
}

func token(type: AccessTokenType, token: String) -> OauthAccessTokenType {
    switch type {
    case .bearer:
        return BearerAccessToken(token: token)
    case .jwt:
        return JWTTokenAccess(token: token)
    default: return CommonAccessToken(token: token)
    }
}