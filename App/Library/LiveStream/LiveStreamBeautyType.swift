//
// Created by Yamazhiki on 19/03/2018.
// Copyright (c) 2018 ENT-LIVE. All rights reserved.
//

import Foundation

protocol LiveStreamBeautyType {

    /// 美颜效果
    ///
    /// - Parameters:
    ///   - style: 磨皮风格 0~9
    ///   - level: 磨皮级别 0~9
    ///   - whitenessLevel: 美白级别 0~9
    ///   - ruddinessLevel: 红润级别 0~9
    func configBeauty(style: Int, level: Float, whitenessLevel: Float, ruddinessLevel: Float)
}
