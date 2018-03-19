//
// Created by Yamazhiki on 19/03/2018.
// Copyright (c) 2018 ENT-LIVE. All rights reserved.
//

import Foundation

protocol LiveStreamControllerType {
    func pushOnlyAudio(isAudio: Bool)
    func switchCamera(isFront: Bool)
}
