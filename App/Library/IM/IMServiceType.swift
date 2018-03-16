//
//  IMServiceType.swift
//  ENT-LIVE
//
//  Created by 斌王 on 09/03/2018.
//  Copyright © 2018 斌王. All rights reserved.
//

import Foundation
import RxSwift

enum IMConversionType: Int {
    case C2C
    case GROUP
    case SYSTEM
}

struct IMUserIdentifier {
    let name: String
    let token: String
    let appId: String
}


protocol IMServiceType {
    func login(id: IMUserIdentifier)
    func send(type: IMConversionType, message: IMMessage, receiver: String) -> Observable<(Int, String?)>
    func logout()
}
