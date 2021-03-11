//
//  UIViewController+Extension.swift
//  MJExtension
//
//  Created by chenminjie on 2020/11/7.
//

import UIKit
import RTRootNavigationController
import MBProgressHUD

extension UIViewController {
    
    public enum MJHUDStyle {
        case light
        case dark
    }
}

extension TypeWrapperProtocol where WrappedType: UIViewController {
    
    public static var window: UIWindow? {
        get {
            var window: UIWindow? = nil
            if #available(iOS 13, *) {
                window  = UIApplication.shared.windows.filter{ $0.isKeyWindow }.first
            } else {
                window = UIApplication.shared.keyWindow
            }
            return window
        }
    }
    
    /// pop 到指定类型的控制器, return true表示pop成功
    @discardableResult
    public func popTo(controller: AnyClass) -> Bool {
        guard let vcs = wrappedValue.navigationController?.viewControllers else {
            return false
        }
        
        var find: UIViewController?
        for vc in vcs.reversed() {
            if vc.isMember(of: controller) {
                find = vc
                break
            }
        }
        
        if let tfind = find {
            wrappedValue.navigationController?.popToViewController(tfind, animated: true)
            return true
        } else {
            return false
        }
    }
    
    // MARK: 导航栏是否隐藏
    public func prefersNavigationBar(hidden: Bool) {
        if let navigation = wrappedValue.navigationController {
            navigation.isNavigationBarHidden = hidden
        }
    }
    
    /// 移除指定的Controller类型的controller
    ///
    /// - Parameter controllerTypes: 类数组
    public func remove(controllerTypes: [AnyClass]) {
        guard let vcs = wrappedValue.navigationController?.viewControllers else {
            return
        }
        let res = vcs.filter { (vc) -> Bool in
            var find = false
            for type in controllerTypes {
                if vc.isMember(of: type) {
                    find = true
                    break
                }
            }
            return !find
        }
        if res.count < vcs.count {
            wrappedValue.navigationController?.viewControllers = res
        }
    }
    
    public func setRightNaviItem(image: UIImage?, target: Any?, selector: Selector) {
        guard let image = image else {
            return
        }
        let button = UIButton()
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.setImage(image, for: .normal)
        if image.size.width < 44 {
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 44 - image.size.width, bottom: 0, right: 0)
        }
        wrappedValue.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @discardableResult
    public func setRightNaviItem(title: String?, color: UIColor = UIColor.blue, target: Any?, selector: Selector) -> UIButton? {
        guard let title = title else {
            return nil
        }
        var button = UIButton()
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.sizeToFit()
        button.ext.height = 44
        wrappedValue.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        return button
    }
    
    /// 获取当前控制器
    public static func currentViewController() -> UIViewController? {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            return Self.findBestViewController(vc: vc)
        }
        return nil
    }
    
    private static func findBestViewController(vc: UIViewController) -> UIViewController {
        
        if vc.presentedViewController != nil {
            return Self.findBestViewController(vc: vc.presentedViewController!)
        } else if let svc = vc as? UISplitViewController {
            if svc.viewControllers.count > 0 {
                return Self.findBestViewController(vc: svc.viewControllers.last!)
            } else {
                return vc
            }
        } else if let nvc = vc as? UINavigationController {
            if nvc.viewControllers.count > 0 {
                return Self.findBestViewController(vc: nvc.topViewController!)
            } else {
                return vc
            }
        } else if let tvc = vc as? UITabBarController {
            if (tvc.viewControllers?.count)! > 0 {
                return Self.findBestViewController(vc: tvc.selectedViewController!)
            } else {
                return vc
            }
        } else {
            if let rtvc = vc as? RTContainerController {
                return Self.findBestViewController(vc: rtvc.contentViewController!)
            }
            return vc
        }
    }
}


/// hud
extension TypeWrapperProtocol where WrappedType: UIView {
    
    /// 隐藏hud
    public func hideHUD() {
        MBProgressHUD.hide(for: wrappedValue, animated: true)
    }
    
    /// 显示文本hud
    public func showMessage(_ text: String? = nil, style: UIViewController.MJHUDStyle = .dark, completion: (() -> Void)? = nil) {
        wrappedValue.ext.hideHUD()
        let hud = MBProgressHUD.showAdded(to: wrappedValue, animated: true)
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
        hud.completionBlock = {
            if let _completion = completion {
                _completion()
            }
        }
    }
    
    /// 显示加载
    public func showLoading(_ text: String? = nil, style: UIViewController.MJHUDStyle = .dark) {
        wrappedValue.ext.hideHUD()
        let hud = MBProgressHUD.showAdded(to: wrappedValue, animated: true)
        hud.mode = .indeterminate
        if style == .dark {
            hud.bezelView.style = .solidColor
            hud.bezelView.backgroundColor = UIColor.init(red: 30.0/255, green: 29.0/255, blue: 29.9/255, alpha: 1)
        }
        hud.label.font =  UIFont.systemFont(ofSize: 14, weight: .medium)
        hud.label.textColor = UIColor.white
        hud.label.text = text
        hud.removeFromSuperViewOnHide = true
    }
    
}

