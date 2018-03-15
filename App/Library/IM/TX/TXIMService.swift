//
// Created by yamazhiki on 09/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import RxSwift

class TXIMService: IMServiceType {

    private let manager: TIMManager

    init() {
        manager = TIMManager.init()
    }

    func login(id: IMUserIdentifier) {
        let param = TIMLoginParam.init()
        param.identifier = id.name
        param.userSig = id.token
        param.appidAt3rd = id.appId

        manager.login(param, succ: {

        }, fail: { code, msg in

        })
    }

    func send(type: IMConversionType, container: IMMsgContainer, receiver: String) -> Observable<Int> {
        let conversion = manager.getConversation(TIMConversationType.init(rawValue: type.rawValue)!, receiver: receiver)
        var msg: TIMMessage = TIMMessage()
        switch container.type {
        case .text:
            msg = IMMsgFactory.textMessage(text: container.body)
        default: break
        }
        conversion?.send(msg, succ: nil, fail: nil)
        return Observable.just(1)
    }

    func logout() {
        manager.logout(nil, fail: nil)
    }
}
