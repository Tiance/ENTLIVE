//
// Created by Yamazhiki on 21/03/2018.
// Copyright (c) 2018 ENT-LIVE. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    func retrieveView<T>(type: T.Type, tag: Int) -> T {
        guard let rlt = self.contentView.viewWithTag(tag) as? T
                else {
            fatalError("不能找到指定的View")
        }
        return rlt
    }
}
