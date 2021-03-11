//
//  UIColor+Extension.swift
//  MJExtension
//
//  Created by chenminjie on 2020/11/7.
//

import Foundation

extension TypeWrapperProtocol where WrappedType: UIColor {
    
    /// 接受HEX类型的颜色，比如#FCD935 写成 0xFCD935
    ///
    /// - Parameters:
    ///   - hex6: HEX类型的颜色
    ///   - alpha: 透明值
    public static func hex(_ hex6: UInt32, alpha: CGFloat = 1) -> UIColor {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
