//
// Created by yamazhiki on 15/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import UIKit


enum AppControllerRouter: String, ControllerRouterType {
    case one
    case two
    case login
    case test


    var controller: UIViewController {
        return instantiate
    }

    var instantiate: UIViewController {
        let typeStr = self.rawValue.capitalized
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
        if let vc = UIStoryboard(name: typeStr, bundle: nil).instantiateInitialViewController() {
            return vc
        }

        if let vc = NSClassFromString("\(namespace).\(typeStr)ViewController") as? UIViewController.Type {
            return vc.init()
        }

        fatalError("没有能够找到\(typeStr)ViewController")
    }
}


enum MessageRouter: MessageRouterType {
    case gift(name: String)
}

extension MessageRouter: Equatable {

}

func ==(lhs: MessageRouter, rhs: MessageRouter) -> Bool {
    switch (lhs, rhs) {
    case (.gift(name: _), .gift(name: _)): return true
    }
}
