//
// Created by yamazhiki on 08/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import RxSwift

struct LiveRoomOption {
    let id: Int
}

public protocol LiveStreamUserType {

    func login() -> Observable<Int>
    func logout() -> Observable<Int>

    func createRoom() -> Observable<Int>

    func joinRoom() -> Observable<Int>
}
