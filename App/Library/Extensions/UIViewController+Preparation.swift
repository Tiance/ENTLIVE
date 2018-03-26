//
// Created by yamazhiki on 14/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import UIKit
import Prelude
import RxSwift

private func swizzle(_ vc: UIViewController.Type) {

    [
        (#selector(vc.viewDidLoad), #selector(vc.ent_viewDidLoad)),
        (#selector(vc.viewWillAppear(_:)), #selector(vc.ent_viewWillAppear(_:))),
        (#selector(vc.traitCollectionDidChange(_:)), #selector(vc.ent_traitCollectionDidChange(_:)))
    ].forEach { original, swizzled in

        guard let originalMethod = class_getInstanceMethod(vc, original),
              let swizzledMethod = class_getInstanceMethod(vc, swizzled) else {
            return
        }

        let didAddViewDidLoadMethod = class_addMethod(vc,
                original,
                method_getImplementation(swizzledMethod),
                method_getTypeEncoding(swizzledMethod))

        if didAddViewDidLoadMethod {
            class_replaceMethod(vc,
                    swizzled,
                    method_getImplementation(originalMethod),
                    method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}

private var hasSwizzled = false

extension UIViewController {
    final public class func doBadSwizzleStuff() {
        guard !hasSwizzled else {
            return
        }

        hasSwizzled = true
        swizzle(self)
    }

    @objc internal func ent_viewDidLoad() {
        self.ent_viewDidLoad()
        bindViewModel()
    }

    @objc internal func ent_viewWillAppear(_ animated: Bool) {
        self.ent_viewWillAppear(animated)

        if !self.hasViewAppeared {
            self.hasViewAppeared = true
        }
    }

    @objc open func bindViewModel() {
    }

    @objc open func bindStyle() {

    }

    @objc public func ent_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.ent_traitCollectionDidChange(previousTraitCollection)
    }

    private struct AssociatedKeys {
        static var hasViewAppeared = "hasViewAppeared"
    }

    // Helper to figure out if the `viewWillAppear` has been called yet
    private var hasViewAppeared: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.hasViewAppeared) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self,
                    &AssociatedKeys.hasViewAppeared,
                    newValue,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIViewController {
    public static var defaultNib: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }

    public static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
}
