//
// Created by yamazhiki on 15/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

private struct RouterNode {
    let pre: UIViewController
    let requestCode: Int
}

class RouterManager<T: MessageRouterType> {

    private var stack: [UIViewController: RouterNode] = [:]

    fileprivate func add(_ from: UIViewController, to: UIViewController) {
        let node = RouterNode.init(pre: from, requestCode: 0)
        stack[to] = node
    }

    fileprivate func node(vc: UIViewController) -> RouterNode? {
        return stack[vc]
    }

    fileprivate func dismiss(vc: UIViewController) {
        stack.removeValue(forKey: vc)
        assert(stack[vc] == nil)
    }

}

extension UIViewController {

    func push(routerType: ControllerRouterType, requestCode: Int, intent: Intent? = nil) {
        assert(self.navigationController != nil, "没有发现可用的UINavigationController")
        let vc = routerType.controller
        vc.intent = intent
        AppEnvironment.current.router.add(self, to: vc)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func present(routerType: ControllerRouterType, requestCode: Int) {
        self.present(routerType.controller, animated: true, completion: nil)
    }

    func pop(resultCode: Int, intent: Intent? = nil) {
        if let node = AppEnvironment.current.router.node(vc: self) {
            node.pre.onRequestResult(intent)
        }

        AppEnvironment.current.router.dismiss(vc: self)
        navigationController?.popViewController(animated: true)
    }

    func dismiss(resultCode: Int, intent: Intent? = nil) {

    }

    @objc func onRequestResult(_ intent: Intent?) {

    }

    private struct AssociatedIntentKeys {
        static var intent = "intent"
    }

    private (set) var intent: Intent? {
        get {
            return objc_getAssociatedObject(self, &AssociatedIntentKeys.intent) as? Intent
        }
        set {
            objc_setAssociatedObject(self,
                    &AssociatedIntentKeys.intent,
                    newValue,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
