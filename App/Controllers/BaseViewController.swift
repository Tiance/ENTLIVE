//
// Created by yamazhiki on 13/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import RxSwift

#if os(iOS)
import UIKit

typealias BaseViewController = UIViewController
#elseif os(macOS)
import Cocoa

typealias BaseViewController = NSViewController
#endif

class RxViewController: BaseViewController {
#if TRACE_RESOURCES
    private let startResourceCount = RxSwift.Resources.total
#endif

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
#if TRACE_RESOURCES
        print("Number of start resources = \(Resources.total)")
#endif
    }

    deinit {
#if TRACE_RESOURCES
        print("View controller disposed with \(Resources.total) resources")

        let numberOfResourcesThatShouldRemain = startResourceCount
        let mainQueue = DispatchQueue.main

        let when = DispatchTime.now() + DispatchTimeInterval.milliseconds(OSApplication.isInUITest ? 1000 : 100)

        mainQueue.asyncAfter(deadline: when) {

            assert(Resources.total <= numberOfResourcesThatShouldRemain, "Resources weren't cleaned properly, \(Resources.total) remained, \(numberOfResourcesThatShouldRemain) expected")
        }
#endif
    }
}
