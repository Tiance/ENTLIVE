//
// Created by yamazhiki on 06/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import Moya
import Result
import RxSwift

public protocol ENTTargetType {
    var path: String { get }
    var method: Moya.Method { get }
    var sampleData: Data { get }
    var task: Task { get }
}

public enum ENTTarget {
    case users
    case singleUser(id: Int)
    case detail(id: Int)
}

extension ENTTarget: ENTTargetType {
    public var path: String {
        switch self {
        case .users: return "users"
        case .singleUser(let id):return "user/\(id)"
        case .detail(let id): return "detail/\(id)"
        }
    }
    public var method: Moya.Method {
        return .get
    }

    public var sampleData: Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        switch self {
        case .users:
            let sample = User(id: 0, login: "Sample-data")
            return try! encoder.encode(sample)
        case .singleUser(let id):
            let sample = User(id: id, login: "Sample-data")
            return try! encoder.encode(sample)
        case .detail(_):
            return Data()
        }
    }
    public var task: Task {
        switch self {
        case .detail(let id):
            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
}

public struct ENTDynamicTarget: TargetType {
    public let baseURL: URL
    let target: ENTTargetType

    public init(baseURL: URL, target: ENTTargetType) {
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

public class ENTApiProvider<T: ENTTargetType>: MoyaProvider<ENTDynamicTarget> {

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
        let dynamic = ENTDynamicTarget(baseURL: baseURL, target: target)
        return super.request(dynamic, callbackQueue: callbackQueue, progress: progress, completion: completion)
    }


    public func requestWithResponse(_ target: T) -> Observable<Response> {
        let dynamic = ENTDynamicTarget(baseURL: baseURL, target: target)
        return self.rx.request(dynamic).asObservable()
    }
}
