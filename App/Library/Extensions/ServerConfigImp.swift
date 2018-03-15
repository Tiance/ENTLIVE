//
// Created by yamazhiki on 06/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import Api

extension ServerConfigImp {
    static func from(env: EnvironmentType) -> ServerConfigType {
        switch env {
        case .simulate: return ServerConfigImp.simulation
        case .dev: return ServerConfigImp.dev
        default: return ServerConfigImp.production
        }
    }
}