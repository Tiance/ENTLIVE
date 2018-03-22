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
        return stub(type: self)
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

fileprivate func stub(type: Client) -> Data {
    if let url = Bundle.main.url(forResource: "\(type)", withExtension: "json"),
       let data = try? Data.init(contentsOf: url) {
        return data
    }
    return Data()
}
