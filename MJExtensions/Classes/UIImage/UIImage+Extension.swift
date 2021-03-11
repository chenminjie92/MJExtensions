//
//  UIImage+Extension.swift
//  MJExtensions
//
//  Created by chenminjie on 2020/11/9.
//

import Foundation
import UIKit

extension UIImage {

    public enum BundleName: String {
        case mineModule = "MineModule"
        case showModule = "ShowModule"
    }
}

extension TypeWrapperProtocol where WrappedType: UIImage {
    
    /// 构建单色图片
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 大小
    public static func getImage(_ tintColor:UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {

        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(tintColor.cgColor)
        context?.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else {return nil}
        return UIImage.init(cgImage: cgImage)
    }
        
    /// 调整图片颜色
    /// - Parameter tintColor: 颜色
    /// - Returns: 图片
    public func getImage(_ tintColor:UIColor) -> UIImage? {

        UIGraphicsBeginImageContextWithOptions(self.wrappedValue.size, false, 0.0)

        tintColor.setFill()

        let bounds = CGRect.init(x: 0, y: 0, width: self.wrappedValue.size.width, height: self.wrappedValue.size.height)

        UIRectFill(bounds)

        self.wrappedValue.draw(in: bounds, blendMode: .destinationIn, alpha: 1.0)

        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return tintedImage
    }
    
    /// 获取图片
    /// - Parameters:
    ///   - name: 图片名称
    ///   - resource: 模块名称
    /// - Returns: 图片
    public static func getImage(named name: String, bundleName: UIImage.BundleName) -> UIImage {
        var image: UIImage? = nil
        let libraryBundle = Bundle.main.path(forResource: bundleName.rawValue , ofType: "bundle")
        let bundle = Bundle.init(path: libraryBundle ?? "")
        image = UIImage.init(named: name, in: bundle, compatibleWith: nil)
        if image == nil {
            image = UIImage.init(named: name)
        }
        return image ?? UIImage()
    }
    
    public func transportImageAlpha(alpha:CGFloat) ->UIImage?{
        UIGraphicsBeginImageContextWithOptions(self.wrappedValue.size, false, 0.0)
        guard let ctx = UIGraphicsGetCurrentContext(),let cgImage = self.wrappedValue.cgImage else{
            return nil
        }
        let area = CGRect(x: 0, y: 0, width: self.wrappedValue.size.width, height: self.wrappedValue.size.height)
        ctx.scaleBy(x: 1, y: -1)
        ctx.translateBy(x: 0, y: -area.size.height)
        ctx.setAlpha(alpha)
        ctx.draw(cgImage, in: area)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    public static func createImage(color: UIColor, viewSize: CGSize) -> UIImage{
        let rect: CGRect = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)

        UIGraphicsBeginImageContext(rect.size)

        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        return image!
    }
}


extension TypeWrapperProtocol where WrappedType: UIImage {
    
    /// 压缩图片
    /// - Returns: 图片data
    public func autoCompressImage() -> Data? {
        return wrappedValue.ext.compressImage(1000, compressionQuality: 0.6)
    }
    
    /// 压缩图片
    /// - Parameters:
    ///   - size: 尺寸
    ///   - quality: 压缩质量
    public func compressImage(_ size: CGFloat, compressionQuality quality:CGFloat) -> Data? {
        let resized: UIImage = wrappedValue.ext.scaleImage(with: size)
        return resized.jpegData(compressionQuality: quality)
    }
    
    /// 缩放图片
    /// - Parameter maxSize: 允许的最大尺寸，（width或height）
    /// - Returns: 图片
    public func scaleImage(with maxSize: CGFloat) -> UIImage {
        
        let currentSize: CGSize = CGSize.init(width: wrappedValue.size.width * wrappedValue.scale, height: wrappedValue.size.height * wrappedValue.scale)
        let currentMax: CGFloat = currentSize.width > currentSize.height ? currentSize.width : currentSize.height
        if currentMax <= maxSize {
            return wrappedValue
        }
        
        //缩放
        let scale = maxSize / currentMax
        let scaledSize = CGSize.init(width: scale * currentSize.width, height: scale * currentSize.height)
        UIGraphicsBeginImageContext(scaledSize)
        guard let context: CGContext = UIGraphicsGetCurrentContext() else {
            return wrappedValue
        }
        //坐标系矫正
        context.translateBy(x: 0, y: scaledSize.height)
        context.scaleBy(x: 1.0, y: -1.0)
        wrappedValue.draw(in: CGRect(x: 0, y: 0, width: scaledSize.width, height: scaledSize.height))
        let smallImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let _cgImage = smallImage?.cgImage {
            return UIImage.init(cgImage: _cgImage, scale: UIScreen.main.scale, orientation: wrappedValue.imageOrientation)
        }
        return wrappedValue
    }
    
    
    /// 获取图片
    /// - Parameters:
    ///   - name: 图片名称
    ///   - bundleName: 模块名称
    /// - Returns: 图片
    public static func getImage(named name: String, bundleName: String) -> UIImage {
        var image: UIImage? = nil
        let libraryBundle = Bundle.main.path(forResource: bundleName , ofType: "bundle")
        let bundle = Bundle.init(path: libraryBundle ?? "")
        image = UIImage.init(named: name, in: bundle, compatibleWith: nil)
        if image == nil {
            image = UIImage.init(named: name)
        }
        return image ?? UIImage()
    }
}
