//
//  RoomChatViewModel.swift
//  ENTLIVE
//
//  Created by 姜楠 on 2018/3/23.
//  Copyright © 2018年 斌王. All rights reserved.
//

import UIKit
import RxSwift

internal protocol RoomChatViewModelInputs {
    func input(message: [Message])
}

internal protocol RoomChatViewModelOutputs {
    var output: Observable<[RoomMessage]> { get }
}

internal protocol RoomChatViewModelType {
    var inputs: RoomChatViewModelInputs { get }
    var outputs: RoomChatViewModelOutputs { get }
}

internal struct RoomChatViewModel: RoomChatViewModelType, RoomChatViewModelInputs, RoomChatViewModelOutputs {
    var output: Observable<[RoomMessage]>

    var inputs: RoomChatViewModelInputs {
        return self
    }

    var outputs: RoomChatViewModelOutputs {
        return self
    }

    private let resultSubject = PublishSubject<[RoomMessage]>()

    init() {
        output = resultSubject.asObservable()
    }

    func input(message: [Message]) {
        var msgs: [Message] = []
        for m in message {
            msgs.append(m)
        }
        let roomMessage = RoomMessage(items: msgs)
        resultSubject.onNext([roomMessage])
    }

}
