//
// Created by Yamazhiki on 19/03/2018.
// Copyright (c) 2018 ENT-LIVE. All rights reserved.
//

import Foundation
import RxSwift

protocol LiveStreamRoomType {
    func enter(roomId: UInt32) -> Observable<Int>
    func leave() -> Observable<Int>
}
