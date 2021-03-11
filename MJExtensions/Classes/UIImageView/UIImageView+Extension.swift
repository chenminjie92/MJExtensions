//
//  UIImageView+Extension.swift
//  MJExtension
//
//  Created by chenminjie on 2020/11/7.
//

import Foundation
import Kingfisher

extension UIImageView {

    public enum DownloadPriority {
        case low
        case high
        case `default`
        case custom(Float)

        var value: Float {
            switch self {
            case .low:
                return URLSessionTask.lowPriority
            case .high:
                return URLSessionTask.highPriority
            case .`default`:
                return URLSessionTask.defaultPriority
            case let .custom(_value):
                return (1.0 >= _value && _value >= 0.0) ? _value: URLSessionTask.defaultPriority
            }
        }
    }
}

extension TypeWrapperProtocol where WrappedType: UIImageView {
    
    /// 图片加载
    ///
    /// - Parameters:
    ///   - resource: 图片资源
    ///   - placeholder: 占位图
    ///   - options: 类型
    ///   - progressBlock: 进度
    ///   - completionHandler: 完成回调
    /// - Returns:
    @discardableResult
    public func setImage(with url: String?,
                        placeholder: Placeholder? = nil,
                        options: KingfisherOptionsInfo? = nil,
                        progressBlock: DownloadProgressBlock? = nil,
                        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask? {
        var resource: URL? = nil
        if let url = url {
            resource = url.ext.URLValue
        }
        return wrappedValue.kf.setImage(with: resource, placeholder: placeholder, options: options, progressBlock: progressBlock, completionHandler: completionHandler)
    }
}
