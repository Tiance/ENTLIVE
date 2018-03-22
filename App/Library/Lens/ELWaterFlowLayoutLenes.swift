//
// Created by Yamazhiki on 22/03/2018.
// Copyright (c) 2018 ENT-LIVE. All rights reserved.
//

import Foundation
import UIKit
import Prelude


extension ELWaterFlowLayout {
    enum lens {
        public static let edge = Lens<ELWaterFlowLayout, UIEdgeInsets>(
                view: {
                    return $0.edge
                },
                set: {
                    $1.edge = $0
                    return $1
                }
        )

        public static let lineCount = Lens<ELWaterFlowLayout, UInt>(
                view: { return $0.lineCount },
                set: {
                    $1.lineCount = $0;
                    return $1
                }
        )

        public static let delegate = Lens<ELWaterFlowLayout, ELWaterFlowLayoutDelegate?>(
                view: { return $0.delegate },
                set: {
                    $1.delegate = $0;
                    return $1
                }
        )

        public static let vItemSpace = Lens<ELWaterFlowLayout, CGFloat>(
                view: { return $0.vItemSpace },
                set: {
                    $1.vItemSpace = $0;
                    return $1
                }
        )

        public static let hItemSpace = Lens<ELWaterFlowLayout, CGFloat>(
                view: { return $0.hItemSpace },
                set: {
                    $1.hItemSpace = $0;
                    return $1
                }

        )
    }
}
