//
// Created by yamazhiki on 06/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import Moya
import Result
import RxSwift

public protocol ApiTargetType {
    var path: String { get }
    var method: Moya.Method { get }
    var sampleData: Data { get }
    var task: Task { get }
}


public struct DynamicTarget: TargetType {
    public let baseURL: URL
    let target: ApiTargetType

    public init(baseURL: URL, target: ApiTargetType) {
        self.baseURL = baseURL
        self.target = target
    }

    public var path: String {
        return target.path
    }
    public var method: Moya.Method {
        return target.method
    }
    public var sampleData: Data {
        return target.sampleData
    }

    public var task: Task {
        return target.task
    }
    public var headers: [String: String]? {
        return nil
    }

}

public class ApiProvider<T: ApiTargetType>: MoyaProvider<DynamicTarget> {

    let baseURL: URL

    public init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
                stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
                callbackQueue: DispatchQueue? = nil,
                manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
                plugins: [PluginType] = [],
                trackInflights: Bool = false,
                baseURL: URL) {
        self.baseURL = baseURL
        super.init(endpointClosure: endpointClosure, stubClosure: stubClosure, callbackQueue: callbackQueue, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }

    public func request(_ target: T, callbackQueue: DispatchQueue?, progress: ProgressBlock?, completion: @escaping Completion) -> Cancellable {
        let dynamic = DynamicTarget(baseURL: baseURL, target: target)
        return super.request(dynamic, callbackQueue: callbackQueue, progress: progress, completion: completion)
    }


    public func requestWithResponse(_ target: T) -> Observable<Response> {
        let dynamic = DynamicTarget(baseURL: baseURL, target: target)
        return self.rx.request(dynamic).asObservable()
    }
}
