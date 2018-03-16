//
// Created by Yamazhiki on 16/03/2018.
// Copyright (c) 2018 ENT-LIVE. All rights reserved.
//

import Foundation
import Api
import Moya

extension Client: ApiTargetType {
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
