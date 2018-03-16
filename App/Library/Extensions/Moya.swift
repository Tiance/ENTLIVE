//
// Created by yamazhiki on 06/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Result
import Api

extension EnvironmentType {
    func stubClosure<T: TargetType>() -> (T) -> StubBehavior {
        switch self {
        case .simulate: return MoyaProvider.immediatelyStub
        default: return MoyaProvider.neverStub
        }
    }
}

extension ApiProvider {
    func request<D: Decodable>(target: T) -> Observable<D> {
        return self.requestWithResponse(target)
                .map({ (response) -> D in
                    let data = response.data
                    let decoder = JSONDecoder()
                    return try! decoder.decode(D.self, from: data)
                })
    }
}
