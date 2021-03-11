//
//  UIButton+Extension.swift
//  MJExtension
//
//  Created by chenminjie on 2020/11/7.
//

import Foundation
import Kingfisher

extension UIButton {

    public enum ImageAlignmen {
        case left
        case right
        case bottom
        case top
    }
}

extension TypeWrapperProtocol where WrappedType: UIButton {
    
    /// 设置图片方向
    /// - Parameters:
    ///   - postion: 图片位置
    ///   - ragne: 文本和图片间距
    public func setImagePosition(_ postion: UIButton.ImageAlignmen, titlePacingRange ragne: CGFloat) {
        /**
         *  知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
         *  如果只有title，那它上下左右都是相对于button的，image也是一样；
         *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
         */
        
        // 1. 得到imageView和titleLabel的宽、高
        let imageWith: CGFloat = wrappedValue.imageView?.image?.size.width ?? 0
        let imageHeight: CGFloat = wrappedValue.imageView?.image?.size.height ?? 0
        
        let labelWidth: CGFloat = wrappedValue.titleLabel?.intrinsicContentSize.width ?? 0
        let labelHeight: CGFloat = wrappedValue.titleLabel?.intrinsicContentSize.height ?? 0
        
        // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets: UIEdgeInsets = .zero
        var labelEdgeInsets: UIEdgeInsets = .zero
        
        // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch postion {
        case .top:
            imageEdgeInsets = UIEdgeInsets.init(top: -labelHeight - ragne / 2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageWith, bottom: -imageHeight - ragne / 2, right: 0)
        case .left:
            imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -ragne / 2, bottom: 0, right: ragne / 2)
            labelEdgeInsets = UIEdgeInsets.init(top: 0, left: ragne / 2, bottom: 0, right: -ragne / 2)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -labelHeight + ragne / 2, bottom: 0, right: -labelWidth - ragne / 2)
            labelEdgeInsets = UIEdgeInsets.init(top: -imageHeight - ragne / 2, left: -imageWith , bottom: 0, right: 0)
        case .right:
            imageEdgeInsets = UIEdgeInsets.init(top: 0, left: labelWidth + ragne / 2, bottom: 0, right: -labelWidth - ragne / 2)
            labelEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageWith - ragne / 2 , bottom: 0, right: imageWith + ragne / 2)
        }

        // 4. 赋值
        wrappedValue.titleEdgeInsets = labelEdgeInsets
        wrappedValue.imageEdgeInsets = imageEdgeInsets;
    }
    
    /// 设置背景色
    /// - Parameters:
    ///   - color: 颜色
    ///   - state: 状态
    func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        if let _color = color {
            let image: UIImage? = UIImage.ext.getImage(_color)
            wrappedValue.setBackgroundImage(image, for: state)
        }
        else {
            wrappedValue.setBackgroundImage(nil, for: state)
        }
    }
    
    /// 加载图片
    /// - Parameters:
    ///   - url: url
    ///   - state: 状态
    ///   - placeholder: 占位图
    ///   - options: 类型
    ///   - progressBlock: 进度
    ///   - completionHandler: 完成回调
    /// - Returns: 下载对象
    @discardableResult
    public func setImage(with url: String?,
                         for state: UIControl.State = .normal,
                         placeholder: UIImage? = nil,
                         options: KingfisherOptionsInfo? = nil,
                         progressBlock: DownloadProgressBlock? = nil,
                         completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask? {
        var resource: URL? = nil
        if let url = url {
            resource = url.ext.URLValue
        }
        return wrappedValue.kf.setImage(with: resource, for: state, placeholder:placeholder, options: options, progressBlock: progressBlock, completionHandler: completionHandler)
    }
}
