//
//  UIView+Extension.swift
//  MJExtension
//
//  Created by chenminjie on 2020/11/7.
//

import UIKit
import MBProgressHUD

extension TypeWrapperProtocol where WrappedType: UIView {
    
    /// 左边
    public var left: CGFloat {
        set {
            var frame: CGRect  = wrappedValue.frame
            frame.origin.x = newValue
            wrappedValue.frame = frame;
        }
        get {
            return wrappedValue.frame.origin.x
        }
    }
    
    /// 顶部
    public var top: CGFloat {
        set {
            var frame: CGRect  = wrappedValue.frame
            frame.origin.y = newValue
            wrappedValue.frame = frame;
        }
        get {
            return wrappedValue.frame.origin.y
        }
    }
    
    /// 右边
    public var right: CGFloat {
        set {
            var frame: CGRect  = wrappedValue.frame
            frame.origin.x = newValue - frame.size.width
            wrappedValue.frame = frame;
        }
        get {
            return wrappedValue.frame.origin.x + wrappedValue.frame.size.width
        }
    }
    
    /// 底部
    public var bottom: CGFloat {
        set {
            var frame: CGRect  = wrappedValue.frame
            frame.origin.y = newValue - frame.size.height
            wrappedValue.frame = frame;
        }
        get {
            return wrappedValue.frame.origin.y + wrappedValue.frame.size.height
        }
    }
    
    /// 宽度
    public var width: CGFloat {
        set {
            var frame: CGRect  = wrappedValue.frame
            frame.size.width = newValue
            wrappedValue.frame = frame;
        }
        get {
            return wrappedValue.frame.size.width
        }
    }
    
    /// 高度
    public var height: CGFloat {
        set {
            var frame: CGRect  = wrappedValue.frame
            frame.size.height = newValue
            wrappedValue.frame = frame
        }
        get {
            return wrappedValue.frame.size.height
        }
    }
    
    /// 中心x
    public var centerX: CGFloat {
        set {
            wrappedValue.center = CGPoint.init(x: newValue, y: wrappedValue.center.y)
        }
        get {
            return wrappedValue.center.x
        }
    }
    
    /// 中心y
    public var centerY: CGFloat {
        set {
            wrappedValue.center = CGPoint.init(x: wrappedValue.center.x, y: newValue)
        }
        get {
            return wrappedValue.center.y
        }
    }
    
    /// 大小
    public var size: CGSize {
        set {
            var frame: CGRect  = wrappedValue.frame
            frame.size = newValue
            wrappedValue.frame = frame
        }
        get {
            return wrappedValue.frame.size
        }
    }
}

extension UIView {
    
    public enum MJRadiusStyle {
        case all                       // ----全部圆角
        case top                       // ----顶部圆角
        case left                      // ----左边圆角
        case bottom                    // ----底部圆角
        case right                     // ----右边圆角
        case bottomLeft
        case topLeft
        case topRight
    }
}

extension TypeWrapperProtocol where WrappedType: UIView {
    
    /// 设置不同边的圆角
    ///
    /// - Parameters:
    ///   - style: 圆角类型
    ///   - cornerRadius: 圆角半径大小
    public func cornerRadius(style:UIView.MJRadiusStyle, with cornerRadius:CGFloat) {
        
        let cornerSzie = CGSize.init(width: cornerRadius, height: cornerRadius)
        var maskPath: UIBezierPath? = nil
        wrappedValue.layoutIfNeeded()
      
        switch style {
        case .top:
            maskPath = UIBezierPath(roundedRect: wrappedValue.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: cornerSzie)
        case .left:
            maskPath = UIBezierPath(roundedRect: wrappedValue.bounds, byRoundingCorners:[.topLeft,.bottomLeft], cornerRadii: cornerSzie)
        case .bottom:
            maskPath = UIBezierPath(roundedRect: wrappedValue.bounds, byRoundingCorners:[.bottomLeft,.bottomRight], cornerRadii: cornerSzie)
        case .right:
            maskPath = UIBezierPath(roundedRect: wrappedValue.bounds, byRoundingCorners:[.topRight,.bottomRight], cornerRadii: cornerSzie)
        case .bottomLeft:
            maskPath = UIBezierPath(roundedRect: wrappedValue.bounds, byRoundingCorners:[.bottomLeft], cornerRadii: cornerSzie)
        case .topLeft:
            maskPath = UIBezierPath(roundedRect: wrappedValue.bounds, byRoundingCorners:[.topLeft], cornerRadii: cornerSzie)
        case .topRight:
            maskPath = UIBezierPath(roundedRect: wrappedValue.bounds, byRoundingCorners:[.topRight], cornerRadii: cornerSzie)
        default:
            maskPath = UIBezierPath(roundedRect: wrappedValue.bounds, byRoundingCorners:.allCorners, cornerRadii: cornerSzie)
        }
        
        // 创建layer
        let maskLayer = CAShapeLayer()
        maskLayer.frame = wrappedValue.bounds
        maskLayer.path = maskPath?.cgPath
        
        // 设置新的layer
        wrappedValue.layer.mask = maskLayer
        wrappedValue.layer.masksToBounds = true
    }
    
    /// 视图截取成图片
    ///
    /// - Returns: 截取后的图片
    public func snapshotImage() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(wrappedValue.bounds.size, true, 0)
        wrappedValue.drawHierarchy(in: wrappedValue.bounds, afterScreenUpdates: true)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    public var viewController: UIViewController? {
        get {
            for view in sequence(first: wrappedValue.superview, next: {$0?.superview}){
                if let responder = view?.next{
                    if let _responder = responder as? UIViewController {
                        return _responder
                    }
                }
            }
            return nil
        }
    }
    
    // MARK: - 设置阴影
    public func setViewShadowColor(shadowOpacity: Float, shadowColor: UIColor, shadowOffset: CGSize, radius: CGFloat) {
        
        wrappedValue.layer.shadowOpacity = shadowOpacity
        wrappedValue.layer.shadowColor = shadowColor.cgColor
        wrappedValue.layer.shadowOffset = shadowOffset
        wrappedValue.layer.shadowRadius = radius
        
    }
}

/// hud
extension TypeWrapperProtocol where WrappedType: UIViewController {
    
    /// 隐藏hud
    public func hideHUD() {
        MBProgressHUD.hide(for: wrappedValue.view, animated: true)
    }
    
    /// 显示文本hud
    public func showMessage(_ text: String? = nil, style: UIViewController.MJHUDStyle = .dark) {
        wrappedValue.ext.hideHUD()
        let hud = MBProgressHUD.showAdded(to: wrappedValue.view, animated: true)
        hud.mode = .text
        if style == .dark {
            hud.bezelView.style = .solidColor
            hud.bezelView.backgroundColor = UIColor.init(red: 30.0/255, green: 29.0/255, blue: 29.9/255, alpha: 1)
        }
        hud.label.font =  UIFont.systemFont(ofSize: 14, weight: .medium)
        hud.label.textColor = UIColor.white
        hud.label.text = text
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 0.9)
    }
    
    /// 显示加载
    public func showLoading(_ text: String? = nil, style: UIViewController.MJHUDStyle = .dark) {
        wrappedValue.ext.hideHUD()
        let hud = MBProgressHUD.showAdded(to: wrappedValue.view, animated: true)
        hud.mode = .indeterminate
        if style == .dark {
            hud.bezelView.style = .solidColor
            hud.bezelView.backgroundColor = UIColor.init(red: 30.0/255, green: 29.0/255, blue: 29.9/255, alpha: 1)
        }
        hud.label.font =  UIFont.systemFont(ofSize: 14, weight: .medium)
        hud.label.textColor = UIColor.white
        hud.label.text = text
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 0.9)
    }
    
}

