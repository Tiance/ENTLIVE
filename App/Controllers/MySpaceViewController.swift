//
// Created by yamazhiki on 14/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import UIKit


class MySpaceViewController: RxViewController, HistoryAbleType {
    
    var identifier: String {
        return NSStringFromClass(MySpaceViewController.self)
    }
    
    
    override func collapseSecondaryViewController(_ secondaryViewController: UIViewController, for splitViewController: UISplitViewController) {
        
    }
}
