//
// Created by Yamazhiki on 19/03/2018.
// Copyright (c) 2018 ENT-LIVE. All rights reserved.
//

import Foundation


/// 环境用户发生更新
///
/// - USER_KICKED: 被踢
/// - TOKEN_EXPIRED: Token过期
/// - USER_INFO_UPDATED: 用户信息发生变化
/// - ENV_CHANGED: 环境切换
enum UserEvents {
    case USER_KICKED
    case TOKEN_EXPIRED
    case USER_INFO_UPDATED
    case ENV_CHANGED
}
