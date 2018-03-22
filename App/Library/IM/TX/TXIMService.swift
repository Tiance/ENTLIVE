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

    func send(type: IMConversionType, message: IMMessage, receiver: String) -> Observable<(Int, String?)> {
        let conversion = manager.getConversation(TIMConversationType.init(rawValue: type.rawValue)!, receiver: receiver)
        let el = TIMCustomElem()
        el.data = try? message.serializedData()
        let msg = TIMMessage()
        msg.add(el)
        return Observable.create { observer in
            conversion?.send(msg, succ: {
                observer.onNext((0, nil))
            }, fail: { (code, errorMsg) in
                observer.onNext((0, errorMsg))
            })
            return Disposables.create()
        }
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
                    if let el = m.getElem(i) as? TIMCustomElem {
                        rlt.append(try! IMMessage(serializedData: el.data))
                    }
                }
            }
        }

        messageSubject.onNext(rlt)
    }
}

extension TXIMService: IMMessageMockService {
    func testMessage(type: IMMessage.CMDTYPE, cmd: IMMessage.CMD) {
        let msg = IMMessage.with {
            $0.cmdType = type
            $0.cmd = cmd
        }
        messageSubject.onNext([msg])
    }

    func testMessage() {
        messageSubject.onNext([IMMessage.init()])
    }
}
