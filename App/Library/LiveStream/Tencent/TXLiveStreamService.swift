//
// Created by yamazhiki on 09/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import RxSwift


class TencentLiveStream: LiveStreamType {
    func login() -> Observable<Int> {
        return Observable.just(1)
    }
    
    func logout() -> Observable<Int> {
        return Observable.just(1)
    }
    
    func createRoom() -> Observable<Int> {
        return Observable.just(2)
    }
    
    func joinRoom() -> Observable<Int> {
        return Observable.just(3)
    }
    

}
