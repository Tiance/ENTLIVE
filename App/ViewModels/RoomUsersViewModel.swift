//
//  RoomUsersViewModel.swift
//  ENTLIVE
//
//  Created by 姜楠 on 2018/3/27.
//  Copyright © 2018年 斌王. All rights reserved.
//

import UIKit
import RxSwift

internal protocol RoomUsersViewModelInputs {
    func input(users: [RoomUser])
}

internal protocol RoomUsersViewModelOutputs {
    var output: Observable<[RoomUserSection]> { get }
}

internal protocol RoomUsersViewModelType {
    var inputs: RoomUsersViewModelInputs { get }
    var outputs: RoomUsersViewModelOutputs { get }
}

internal struct RoomUsersViewModel: RoomUsersViewModelType, RoomUsersViewModelInputs, RoomUsersViewModelOutputs {
    let resultSubject = PublishSubject<[RoomUserSection]>()
    var inputs: RoomUsersViewModelInputs {
        return self
    }

    var outputs: RoomUsersViewModelOutputs {
        return self
    }

    func input(users: [RoomUser]) {
        var us: [RoomUser] = []
        for u in users {
            us.append(u)
        }
        let rusection = RoomUserSection(items: us)
        resultSubject.onNext([rusection])
    }

    var output: Observable<[RoomUserSection]>

    init() {
        output = resultSubject.asObserver()
    }
}
