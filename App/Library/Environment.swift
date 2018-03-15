//
// Created by 斌王 on 05/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import Api

struct Environment {

    /// 当前用户
    let currentUser: User

    /// 数据交互Api管理类
    let api: ENTApiProvider<ENTTarget>

    /// 实时聊天
    let imService: IMServiceType

    /// 网络反馈
    let reachability: ReachabilityService

    /// 地理位置坐标
    let geo: GeolocationService = GeolocationService.instance

    /// 内容缓存
    let cache: MemoryCache

    /*路由管理器*/
    let router: RouterManager = RouterManager.instance

    init(
            user: User = User.template,
            api: ENTApiProvider<ENTTarget> = ENTApiProvider.provider,
            imService: IMServiceType = TXIMService(),
            reachability: ReachabilityService = try! DefaultReachabilityService(),
            cache: MemoryCache = MemoryCache()
    ) {
        self.currentUser = user
        self.api = api
        self.imService = imService
        self.reachability = reachability
        self.cache = cache
    }
}

enum EnvironmentType {
    case simulate
    case dev
    case production

    static func from(_ rawValue: Int) -> EnvironmentType {
        switch rawValue {
        case 0: return EnvironmentType.simulate
        case 1: return EnvironmentType.dev
        default:return EnvironmentType.production
        }
    }
}

extension EnvironmentType {
    var serverConfig: ServerConfigType {
        switch self {
        case .simulate: return ServerConfigImp.simulation
        case .dev: return ServerConfigImp.dev
        case .production: return ServerConfigImp.production
        }
    }
}


extension ENTApiProvider {
    static var provider: ENTApiProvider {
        return ENTApiProvider(baseURL: EnvironmentType.dev.serverConfig.apiBaseURL)
    }
}

extension EnvironmentType {
    var stubDelay: Int {
        switch self {
        case .simulate: return 200
        default: return 0
        }
    }
}
