//
//  IMServiceType.swift
//  ENT-LIVE
//
//  Created by 斌王 on 09/03/2018.
//  Copyright © 2018 斌王. All rights reserved.
//

import Foundation
import RxSwift

enum IMConversionType: Int {
    case C2C
    case GROUP
    case SYSTEM
}

struct IMUserIdentifier {
    let name: String
    let token: String
    let appId: String
}

struct IMMsgContainer {
    let type: IMMsgType
    //文字消息
    let body: String

    //图片消息
    let imagePath: String

    //地理坐标
    let lat: Double
    let long: Double

    static func text(body: String) -> IMMsgContainer {
        return IMMsgContainer(type: .text, body: body, imagePath: "", lat: 0, long: 0)
    }
}


protocol IMServiceType {
    func login(id: IMUserIdentifier)
    func send(type: IMConversionType, container: IMMsgContainer, receiver: String) -> Observable<Int>
    func logout()
}
