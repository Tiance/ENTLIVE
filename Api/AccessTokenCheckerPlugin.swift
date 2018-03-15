//
// Created by yamazhiki on 09/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Result

public class AccessTokenCheckerPlugin: PluginType {
    let subject = PublishSubject<Void>()
    let tokenType: OauthAccessTokenType

    public var tokenException: Observable<Void> {
        return subject.asObservable()
    }

    public init(accessTokenType: OauthAccessTokenType) {
        tokenType = accessTokenType
    }

    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var rltRequest = request
        var headers = request.allHTTPHeaderFields ?? [:]
        headers[tokenType.key] = tokenType.value
        rltRequest.allHTTPHeaderFields = headers
        return rltRequest
    }

    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        if result.value?.statusCode == 203 {
            subject.onNext(())
        }
    }
}
