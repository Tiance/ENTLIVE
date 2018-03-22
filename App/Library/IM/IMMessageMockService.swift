//
// Created by Yamazhiki on 22/03/2018.
// Copyright (c) 2018 ENT-LIVE. All rights reserved.
//

import Foundation

protocol IMMessageMockService {
    func testMessage(type: IMMessage.CMDTYPE, cmd: IMMessage.CMD)
}
