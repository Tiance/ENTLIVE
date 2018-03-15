//
// Created by 斌王 on 05/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Api


/// 环境用户发生更新
///
/// - USER_KICKED: 被踢
/// - TOKEN_EXPIRED: Token过期
/// - USER_INFO_UPDATED: 用户信息发生变化
/// - ENV_CHANGED: 环境切换
enum EnvironmentChangedReason {
    case USER_KICKED
    case TOKEN_EXPIRED
    case USER_INFO_UPDATED
    case ENV_CHANGED
}

struct AppEnvironment {
    private static var stack: [Environment] = [Environment()]
    private static let userUpdateSubject = PublishSubject<EnvironmentChangedReason>()
    private static var type = EnvironmentType.simulate

    static var current: Environment {
        return stack.last!
    }

    static func updateUser(user: User) {
        replace(env: Environment(user: user))
    }

    static func auth(accessToken: OauthAccessTokenType) {
        generateApiAndReplace(accessToken: accessToken)
    }

    static func switchEnv(envTypeOrder: Int) {
        type = EnvironmentType.from(envTypeOrder)
        generateApiAndReplace()
    }

    private static func generateApiAndReplace(accessToken: OauthAccessTokenType = CommonAccessToken.template) {
        let endpointClosure = { (target: ENTDynamicTarget) -> Endpoint in
            let endpoint: Endpoint = Endpoint(url: ServerConfigImp.simulation.apiBaseURL.appendingPathComponent(target.path).absoluteString,
                    sampleResponseClosure: { .networkResponse(type.stubDelay, target.sampleData) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers)
            return endpoint
        }
        let api = ENTApiProvider<ENTTarget>(endpointClosure: endpointClosure, stubClosure: type.stubClosure(), plugins: [NetworkLoggerPlugin(), AccessTokenCheckerPlugin(accessTokenType: accessToken)], baseURL: type.serverConfig.apiBaseURL)
        replace(env: Environment(api: api))
    }

    private static func replace(user: User = current.currentUser,
                                api: ENTApiProvider<ENTTarget> = current.api) {
        replace(env: Environment(user: user,
                api: api))
    }

    private static func replace(env: Environment = Environment(
            user: current.currentUser,
            api: current.api
    )) {
        stack.append(env)
        stack.remove(at: stack.count - 2)
    }

    static func fromStorage() -> Environment {
        return Environment()
    }
}
