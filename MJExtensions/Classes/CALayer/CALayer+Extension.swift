//
//  CALayer+Extension.swift
//  MJExtension
//
//  Created by chenminjie on 2020/11/7.
//

import Foundation

extension TypeWrapperProtocol where WrappedType: CALayer {
    
    //        1.shadowColor:阴影颜色,可设置透明度等.
    //        2.shadowOffset:偏移量.,xy表示view左上角,width表示阴影与x的偏移量,height表示阴影与y值的偏移量
    //        3.shadowOpacity = 0.4//阴影透明度,默认为0则看不到阴影.因此要看到阴影这个值必须大于0,shadowColor的透明度也要大于0
    //        4.shadowRadius:5.模糊计算的半径,取平均值的半径,设置为0的话则为一个矩形块.
    //        5.模糊度的解释:每一个像素取平均值,分母的取值范围,越大越模糊.感觉这篇文章讲的比较容易懂
    //        6.注意:如果clipsToBounds设置为YES,则阴影效果消失
    public func addShadow(shadowColor: UIColor, shadowOpacity: CGFloat, shadowRadius: CGFloat, shadowOffset: CGSize) {
        wrappedValue.shadowColor = shadowColor.cgColor
        wrappedValue.shadowOffset = shadowOffset
        wrappedValue.shadowRadius = shadowRadius
        wrappedValue.shadowOpacity = Float(shadowOpacity)
    }
    
}
