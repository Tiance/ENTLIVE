//
// Created by yamazhiki on 09/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class TXLiveStreamService: NSObject {

    let appId: UInt32 = 0
    let userId: UInt64 = 0

    fileprivate let cameraSubject = BehaviorSubject<Bool>(value: true)
    fileprivate let pureAudioPushSubject = BehaviorSubject<Bool>(value: false)
    fileprivate let bgmStatusSubject = BehaviorSubject<Bool>(value: false)

    fileprivate let config: TXLivePushConfig
    fileprivate let livePusher: TXLivePush
    fileprivate let room: TXCAVRoom

    override init() {
        config = TXLivePushConfig()
        livePusher = TXLivePush.init(config: config)
        room = TXCAVRoom(config: nil, andAppId: appId, andUserID: userId)
        super.init()
    }

    func push(_ rtmp: String, inView: UIView) {
        livePusher.startPreview(inView)
        livePusher.start(rtmp)
    }

    func resume() {
        livePusher.resumePush()
    }

    func pause() {
        livePusher.pause()
    }

    func stop() {
        livePusher.stop()
    }
}

extension TXLiveStreamService: TXLivePushListener {

    func onPushEvent(_ EvtID: Int32, withParam param: [AnyHashable: Any]!) {

    }

    func onNetStatus(_ param: [AnyHashable: Any]!) {

    }
}

extension TXLiveStreamService: LiveStreamBgmType {
    func pauseBgm() {

    }

    func resumeBgm() {

    }
}

extension TXLiveStreamService: LiveStreamControllerType {
    func pushOnlyAudio(isAudio: Bool) {
        config.enablePureAudioPush = isAudio
        livePusher.config = config
        livePusher.start(livePusher.rtmpURL)
    }

    func switchCamera(isFront: Bool) {
        livePusher.switchCamera()
    }
}

extension TXLiveStreamService: LiveStreamBeautyType {
    func configBeauty(style: Int, level: Float, whitenessLevel: Float, ruddinessLevel: Float) {
        livePusher.setBeautyStyle(Int32(style), beautyLevel: level, whitenessLevel: whitenessLevel, ruddinessLevel: ruddinessLevel)
    }
}

extension TXLiveStreamService: LiveStreamRoomType {
    func enter(roomId: UInt32) -> Observable<Int> {
        let param = TXCAVRoomParam()
        param.roomID = roomId
        return Observable.create { observer in
            self.room.enter(param) { rlt in
                observer.onNext(Int(rlt))
            }
            return Disposables.create()
        }
    }

    func leave() -> Observable<Int> {
        return Observable.create { observer in
            self.room.exitRoom { rlt in
                observer.onNext(Int(rlt))
            }
            return Disposables.create()
        }
    }
}
