//
//  Rect+Extension.swift
//  MJExtension
//
//  Created by chenminjie on 2020/11/7.
//

import Foundation

extension TypeWrapperProtocol where WrappedType == CGRect {
    
    public func reset(width: CGFloat) -> CGRect {
        return reset(size: CGSize(width: width, height: wrappedValue.size.height))
    }
    
    public func reset(height: CGFloat) -> CGRect {
        return reset(size: CGSize(width: wrappedValue.size.width, height: height))
    }
    
    public func reset(size: CGSize) -> CGRect {
        var rect = wrappedValue
        rect.size = size
        return rect
    }
    
    public func reset(x: CGFloat) -> CGRect {
        return reset(origin: CGPoint(x: x, y: wrappedValue.origin.y))
    }
    
    public func reset(y: CGFloat) -> CGRect {
        return reset(origin: CGPoint(x: wrappedValue.origin.x, y: y))
    }
    
    public func reset(origin: CGPoint) -> CGRect {
        var rect = wrappedValue
        rect.origin = origin
        return rect
    }
}
