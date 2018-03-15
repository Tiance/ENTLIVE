//
// Created by yamazhiki on 09/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import RxSwift

class TXIMService: NSObject, IMServiceType {

    private let manager: TIMManager

    private let messageSubject: PublishSubject<[IMMessage]> = PublishSubject<[IMMessage]>()

    override init() {
        manager = TIMManager.init()
        super.init()
    }

    func login(id: IMUserIdentifier) {
        let param = TIMLoginParam.init()
        param.identifier = id.name
        param.userSig = id.token
        param.appidAt3rd = id.appId

        manager.login(param, succ: {
            self.manager.add(self)
        }, fail: { code, msg in

        })


    }

    func send(type: IMConversionType, container: IMMsgContainer, receiver: String) -> Observable<Int> {
        let conversion = manager.getConversation(TIMConversationType.init(rawValue: type.rawValue)!, receiver: receiver)
        var msg: TIMMessage = TIMMessage()
        switch container.type {
        case .text:
            msg = IMMsgFactory.textMsg(text: container.body)
        case .custom:
            assert(container.ext != nil, "自定义消息不能为空")
            msg = IMMsgFactory.customMsg(message: container.ext!)
        default: break
        }
        conversion?.send(msg, succ: nil, fail: nil)
        return Observable.just(1)
    }

    func logout() {
        manager.logout(nil, fail: nil)
        manager.remove(self)
    }
}

extension TXIMService: TIMMessageListener {

    func onNewMessage(_ msgs: [Any]!) {

        var rlt: [IMMessage] = []

        for item in msgs {
            if let m = item as? TIMMessage {
                for i in 0...m.elemCount() {
                    let el = m.getElem(i)
                    if el is TIMTextElem {

                    } else if el is TIMImageElem {

                    } else if el is TIMCustomElem {
                        rlt.append(IMMessage(cmd: .none, cmdType: .none))
                    }
                }
            }
        }

        messageSubject.onNext(rlt)
    }
}
