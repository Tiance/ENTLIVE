//
// Created by Yamazhiki on 19/03/2018.
// Copyright (c) 2018 ENT-LIVE. All rights reserved.
//

import Foundation
import RxSwift

internal class BaseLiveStreamImp {

    private let cameraPositionSubject = BehaviorSubject<Int>(value: 0)
    
    var cameraPosition: Observable<Int> {
        return cameraPositionSubject.asObservable()
    }

    func login() -> Observable<Int> {
        return Observable.just(1)
    }

    func logout() -> Observable<Int> {
        return Observable.just(1)
    }

    func createRoom() -> Observable<Int> {
        return Observable.just(1)
    }

    func joinRoom() -> Observable<Int> {
        return Observable.just(1)
    }
}
