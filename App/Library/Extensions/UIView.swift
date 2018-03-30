//
//  UIView.swift
//  Live.Me
//
//  Created by Administrator on 2017/7/19.
//  Copyright © 2017年 Yamazhiki(王斌). All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    func retrieveView<T: UIView>(type: T.Type, tag: Int) -> T {
        guard let rlt = contentView.viewWithTag(tag) as? T else {
            fatalError("没有发现对应的Tag View 是\(T.self)的类型")
        }
        return rlt
    }
}

extension UITableViewCell {
    func retrieveView<T: UIView>(type: T.Type, tag: Int) -> T {
        guard let rlt = contentView.viewWithTag(tag) as? T else {
            fatalError("没有发现对应的Tag View 是\(T.self)的类型")
        }
        return rlt
    }
}
extension UIView {
    func controller() -> UIViewController? {
        var next: UIView? = self
        repeat {
            if let nextResponder = next?.next, (nextResponder.isKind(of: UIViewController.self)) {
                return (nextResponder as! UIViewController)
            }
            next = next?.superview
        }while next != nil
        return nil
    }

    /// 裁剪 view 的圆角
    func clipRectCorner(direction: UIRectCorner, cornerRadius: CGFloat) {
        let cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }

    /**/
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    var width: CGFloat {
        get {
            return self.bounds.width
        }
    }
    var height: CGFloat {
        get {
            return self.bounds.height
        }
    }
    /**/

    public var leftX: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }

    public var leftY: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    /// 右边界的x值
    public var rightX: CGFloat {
        get {
            return self.x + self.width
        }
        set {
            var r = self.frame
            r.origin.x = newValue - frame.size.width
            self.frame = r
        }
    }
    /// 下边界的y值
    public var bottomY: CGFloat {
        get {
            return self.y + self.height
        }
        set {
            var r = self.frame
            r.origin.y = newValue - frame.size.height
            self.frame = r
        }
    }

    public var CenterPointX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }

    public var CenterPointY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }

    public var WIdth: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }
    public var HEight: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }

    public var ORigin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            self.x = newValue.x
            self.y = newValue.y
        }
    }

    public var SIze: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.WIdth = newValue.width
            self.HEight = newValue.height
        }
    }
}

public extension UIView {
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }

        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }

        set {
            layer.shadowRadius = newValue
        }
    }
    @IBInspectable public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }

        set {
            layer.shadowOpacity = newValue
        }
    }
    @IBInspectable public var shadowColor: UIColor? {
        get {
            return layer.shadowColor != nil ? UIColor(cgColor: layer.shadowColor!) : nil
        }

        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }

        set {
            layer.shadowOffset = newValue
        }
    }
    @IBInspectable public var zPosition: CGFloat {
        get {
            return layer.zPosition
        }

        set {
            layer.zPosition = newValue
        }
    }
    @IBInspectable public var borderColor: UIColor? {
        get {
            return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil
        }

        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }

        set {
            layer.borderWidth = newValue
        }
    }
}

extension UIImageView {
    func cornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

extension UINavigationBar {
    func changeTintColor(color: UIColor, statusStyle: UIStatusBarStyle = UIStatusBarStyle.default) {
        self.tintColor = color
        self.titleTextAttributes = [NSAttributedStringKey.foregroundColor: color]
        UIApplication.shared.setStatusBarStyle(statusStyle, animated: true)
    }
}

extension UIImage {
    static func createWithView(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: false)
        let snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapshotImageFromMyView
    }
}
