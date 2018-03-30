//
// Created by 斌王 on 05/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
// 全局容器管理器, 管理所有环境, 并暴露相应环境变更的信息
//

import Foundation
import RxSwift
import Moya
import Api

struct AppEnvironment {
    private static let userEventsSubject = PublishSubject<UserEvents>()
    private static let defaults_user_key = "com.ent.live.user"
    private static let defaults_token_key = "com.ent.live.token"
    private static let defaults_tokenType_key = "com.ent.live.tokenType"
    private static let authStatusSubject = PublishSubject<Void>()

    private static var stack: [Environment] = [Environment()]
    private static var type = EnvironmentType.simulate

    static var current: Environment {
        return stack.last!
    }

    static var userEvents: Observable<UserEvents> {
        return Observable.merge(userEventsSubject.asObservable(), authStatusSubject.asObservable().map {
            UserEvents.TOKEN_EXPIRED
        })
    }

    static func updateUser(user: User) {
        replace(env: Environment(user: user))
        userEventsSubject.onNext(.USER_INFO_UPDATED)
    }

    static func auth(accessToken: OauthAccessTokenType) {
        generateApiAndReplace(accessToken: accessToken)
    }

    static func switchEnv(envTypeOrder: Int) {
        type = EnvironmentType.from(envTypeOrder)
        generateApiAndReplace()
    }

    private static func generateApiAndReplace(accessToken: OauthAccessTokenType = CommonAccessToken.template) {
        let endpointClosure = { (target: DynamicTarget) -> Endpoint in
            let endpoint: Endpoint = Endpoint(url: ServerConfigImp.simulation.apiBaseURL.appendingPathComponent(target.path).absoluteString,
                    sampleResponseClosure: { .networkResponse(type.stubDelay, target.sampleData) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers)
            return endpoint
        }
        let tokenChecker = AccessTokenCheckerPlugin(accessTokenType: accessToken, observer: authStatusSubject.asObserver())
        let api = ApiProvider<Client>(endpointClosure: endpointClosure, stubClosure: type.stubClosure(), plugins: [NetworkLoggerPlugin(), tokenChecker], baseURL: type.serverConfig.apiBaseURL)
        replace(env: Environment(api: api))
    }

    private static func replace(user: User = current.currentUser,
                                api: ApiProvider<Client> = current.api,
                                imService: IMServiceType & IMMessageMockService = current.imService,
                                liveStream: LiveStreamType = current.liveStream,
                                reachability: ReachabilityService = current.reachability,
                                cache: MemoryCache = current.cache,
                                router: RouterManager<MessageRouter> = current.router,
                                encoder: JSONEncoder = current.encoder,
                                decoder: JSONDecoder = current.decoder) {
        replace(env: Environment(user: user,
                api: api,
                imService: imService,
                liveStream: liveStream,
                reachability: reachability,
                cache: cache,
                router: router,
                encoder: encoder,
                decoder: decoder))
    }

    static func replace(env: Environment = Environment(
            user: current.currentUser,
            api: current.api,
            imService: current.imService,
            liveStream: current.liveStream,
            reachability: current.reachability,
            cache: current.cache,
            router: current.router,
            encoder: current.encoder,
            decoder: current.decoder
    )) {
        stack.append(env)
        stack.remove(at: stack.count - 2)
    }

    static func fromStorage() -> Environment {
        var user = User.template
        if let data = UserDefaults.standard.data(forKey: defaults_user_key),
           let t = try? JSONDecoder().decode(User.self, from: data) {
            user = t
        }

        if let type = AccessTokenType(rawValue: UserDefaults.standard.integer(forKey: defaults_tokenType_key)),
           let tokenStr = UserDefaults.standard.string(forKey: defaults_token_key) {
            auth(accessToken: token(type: type, token: tokenStr))
        }
        return Environment(user: user)
    }

}
