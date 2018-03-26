//
// Created by 王斌 on 05/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import Api

public struct ServerConfigImp: ServerConfigType {
    public let apiBaseURL: URL
    public let logBaseURL: URL
    public let webBaseURL: URL

}

public extension ServerConfigImp {
    static var simulation: ServerConfigType {
        return ServerConfigImp(apiBaseURL: URL(string: "https://api.github.com/")!, logBaseURL: URL(string: "https://api.github.com/")!, webBaseURL: URL(string: "https://api.github.com/")!)
    }

    static var dev: ServerConfigType {
        return ServerConfigImp(apiBaseURL: URL(string: "https://api.github.com/")!, logBaseURL: URL(string: "https://api.github.com/")!, webBaseURL: URL(string: "https://api.github.com/")!)
    }

    static var production: ServerConfigImp {
        return ServerConfigImp(apiBaseURL: URL(string: "https://api.github.com/")!, logBaseURL: URL(string: "https://api.github.com/")!, webBaseURL: URL(string: "https://api.github.com/")!)
    }
}

extension ServerConfigImp: Equatable {

}

public func ==(lhs: ServerConfigImp, rhs: ServerConfigImp) -> Bool {
    return lhs.apiBaseURL == rhs.apiBaseURL &&
            lhs.logBaseURL == rhs.logBaseURL &&
            lhs.webBaseURL == rhs.webBaseURL
}

extension ServerConfigImp {
    static func from(env: EnvironmentType) -> ServerConfigType {
        switch env {
        case .simulate: return ServerConfigImp.simulation
        case .dev: return ServerConfigImp.dev
        default: return ServerConfigImp.production
        }
    }
}
