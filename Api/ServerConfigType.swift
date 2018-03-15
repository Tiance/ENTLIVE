//
// Created by 王斌 on 05/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation

public protocol ServerConfigType {
    var apiBaseURL: URL { get }
    var logBaseURL: URL { get }
    var webBaseURL: URL { get }
}
