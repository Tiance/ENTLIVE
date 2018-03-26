//
// Created by 斌王 on 05/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
// App唯一容器类定义
//

import Foundation
import Api

typealias LiveStreamType = LiveStreamBeautyType & LiveStreamBeautyType & LiveStreamControllerType & LiveStreamBgmType

struct Environment {

    /// 当前用户
    let currentUser: User

    /// 数据交互Api管理类
    let api: ApiProvider<Client>

    /// 实时聊天
    let imService: IMServiceType

    let liveStream: LiveStreamType

    /// 网络反馈
    let reachability: ReachabilityService

    /// 地理位置坐标
    let geo: GeolocationService = GeolocationService.instance

    /// 内容缓存
    let cache: MemoryCache

    /*路由管理器*/
    let router: RouterManager<MessageRouter>

    /*JSON Encoder*/
    let encoder: JSONEncoder

    /*JSON DeCoder*/
    let decoder: JSONDecoder

    init(
            user: User = User.template,
            api: ApiProvider<Client> = ApiProvider.provider,
            imService: IMServiceType = TXIMService(),
            liveStream: LiveStreamType = TXLiveStreamService(),
            reachability: ReachabilityService = try! DefaultReachabilityService(),
            cache: MemoryCache = MemoryCache(),
            router: RouterManager<MessageRouter> = RouterManager<MessageRouter>(),
            encoder: JSONEncoder = JSONEncoder(),
            decoder: JSONDecoder = JSONDecoder()
    ) {

        self.currentUser = user
        self.api = api
        self.imService = imService
        self.liveStream = liveStream
        self.reachability = reachability
        self.cache = cache
        self.router = router
        self.encoder = encoder
        self.decoder = decoder
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

extension ApiProvider {
    static var provider: ApiProvider {
        return ApiProvider(baseURL: EnvironmentType.dev.serverConfig.apiBaseURL)
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
