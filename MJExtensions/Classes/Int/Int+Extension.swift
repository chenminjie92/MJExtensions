//
//  Int+Extension.swift
//  MJExtension
//
//  Created by chenminjie on 2020/11/7.
//

import Foundation

//根据屏幕尺寸等比缩放， 以375宽度为基准
public func MJ_Scale(size: CGFloat) -> CGFloat { return (UIScreen.main.bounds.size.width / 375.0 * size) }
//根据屏幕尺寸等比缩放， 以667高度为基准
public func MJ_ScaleHeight(size: CGFloat) -> CGFloat { return (UIScreen.main.bounds.size.height / 667.0 * size) }

public protocol SizeCanScaled {
    var scale: CGFloat { get }
    var scaleHeight: CGFloat { get }
}

extension Int: NamespaceWrappable{}
extension TypeWrapperProtocol where WrappedType == Int {
    
    
    public var scale: CGFloat {
        return MJ_Scale(size: CGFloat(wrappedValue))
    }
    public var scaleHeight: CGFloat {
        return MJ_ScaleHeight(size: CGFloat(wrappedValue))
    }
}

extension Double: NamespaceWrappable{}
extension TypeWrapperProtocol where WrappedType == Double {
    public var scale: CGFloat {
        return MJ_Scale(size: CGFloat(wrappedValue))
    }
    public var scaleHeight: CGFloat {
        return MJ_ScaleHeight(size: CGFloat(wrappedValue))
    }
}

extension Float: NamespaceWrappable{}
extension TypeWrapperProtocol where WrappedType == Float {
    public var scale: CGFloat {
        return MJ_Scale(size: CGFloat(wrappedValue))
    }
    public var scaleHeight: CGFloat {
        return MJ_ScaleHeight(size: CGFloat(wrappedValue))
    }
}

extension CGFloat: NamespaceWrappable{}
extension TypeWrapperProtocol where WrappedType == CGFloat  {
    public var scale: CGFloat {
        return MJ_Scale(size: wrappedValue)
    }
    public var scaleHeight: CGFloat {
        return MJ_ScaleHeight(size: wrappedValue)
    }
}
