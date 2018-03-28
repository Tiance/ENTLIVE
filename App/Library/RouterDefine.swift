//
// Created by yamazhiki on 15/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
// 此文件为App ViewController 定义的地方
// 约定如下 枚举首字母大写找到有Storyboard文件, 若找不到Storyboard文件则加上"ViewController"找到指定的ViewController
//

import Foundation
import UIKit

enum AppControllerRouter: String, ControllerRouterType {
    case one
    case two
    case login
    case test
    case RoomChat
    case Login
    case TestLive

    var controller: UIViewController {
        return instantiate
    }

    var instantiate: UIViewController {
        let typeStr = self.rawValue
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
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
