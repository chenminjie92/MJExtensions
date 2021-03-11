//
//  String.swift
//  MJExtension
//
//  Created by chenminjie on 2020/11/7.
//

import Foundation
import CommonCrypto
import CryptoSwift

extension String: NamespaceWrappable { }
extension TypeWrapperProtocol where WrappedType == String {
    
    /// 返回字符串是否为空或者都是空格和换行
    public var isBlank: Bool {
        let trimmedStr = wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }
    
    /// 去除空格和换行后的字符串
    public var discardedBlank: String {
        let trimmedStr = wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr
    }
    
    public var URLValue: URL? {
        guard let data = wrappedValue.data(using: .utf8) else {
            return nil
        }
        return URL(dataRepresentation: data, relativeTo: nil)
    }
    
    /// md5字符串
    public var md5: String {
        guard let data = wrappedValue.data(using: .utf8) else {
            return wrappedValue
        }
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        #if swift(>=5.0)
        _ = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
            return CC_MD5(bytes.baseAddress, CC_LONG(data.count), &digest)
        }
        #else
        _ = data.withUnsafeBytes { bytes in
            return CC_MD5(bytes, CC_LONG(data.count), &digest)
        }
        #endif
        
        return digest.reduce(into: "") { $0 += String(format: "%02x", $1) }
    }
    
    /// sha1
    public var sha1: String {
        return wrappedValue.sha1()
    }
    
    /// wrappedValue64编码
    ///
    /// - Returns: 编码后的字符串
    public func towrappedValue64() -> String {
        guard let strData = wrappedValue.data(using: .utf8) else {
            return wrappedValue
        }
        return strData.base64EncodedString()
    }
    
    /// wrappedValue64解码
    ///
    /// - Returns: 解码后的字符串
    public func fromwrappedValue64() -> String {
        guard let strData = wrappedValue.data(using: .utf8) else {
            return wrappedValue
        }
        return String.init(data: strData, encoding: .utf8) != nil ? String.init(data: strData, encoding: .utf8)! : wrappedValue
    }
    
    /// aes128加密
    ///
    /// - Parameters:
    ///   - key: 加密的key
    ///   - initVector: key的偏移量
    /// - Returns: 加密后的字符串
    public func encryptAES128(_ key: String,
                              initVector: String) -> String {
        
        guard key.count == kCCKeySizeAES128, let keyData = key.data(using: .utf8) else {
            debugPrint("Error: Failed to set a key.")
            return wrappedValue
        }
        
        guard initVector.count == kCCBlockSizeAES128, let ivData = initVector.data(using: .utf8) else {
            debugPrint("Error: Failed to set an initial vector.")
            return wrappedValue
        }
        guard let strData = wrappedValue.data(using: .utf8) else {
            return wrappedValue
        }
        do {
            let aes = try AES.init(key: keyData.bytes, blockMode: CBC(iv: ivData.bytes), padding: .pkcs7)
            let ciphertext = try aes.encrypt(strData.bytes)
            return ciphertext.toHexString();
        } catch {
            return wrappedValue
        }
    }
    
    /// aes128解密
    ///
    /// - Parameters:
    ///   - key: 加密的key
    ///   - initVector: key的偏移量
    /// - Returns: 解密后的字符串
    public func decryptAES128(_ key: String,
                              initVector: String) -> String {
        
        guard key.count == kCCKeySizeAES128, let keyData = key.data(using: .utf8) else {
            debugPrint("Error: Failed to set a key.")
            return wrappedValue
        }
        
        guard initVector.count == kCCBlockSizeAES128, let ivData = initVector.data(using: .utf8) else {
            debugPrint("Error: Failed to set an initial vector.")
            return wrappedValue
        }
        guard let strData = wrappedValue.data(using: .utf8) else {
            return wrappedValue
        }
        do {
            let aes = try AES.init(key: keyData.bytes, blockMode: CBC(iv: ivData.bytes), padding: .pkcs7)
            let ciphertext = try aes.decrypt(strData.bytes)
            return ciphertext.toHexString();
        } catch {
            return wrappedValue
        }
    }
    
}

extension TypeWrapperProtocol where WrappedType == String {
    
    public func index(from: Int) -> String.Index {
        return self.wrappedValue.index(self.wrappedValue.startIndex, offsetBy: from)
    }

    public func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self.wrappedValue[fromIndex...])
    }

    public func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self.wrappedValue[..<toIndex])
    }

    public func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self.wrappedValue[startIndex..<endIndex])
    }
}

extension TypeWrapperProtocol where WrappedType == String {
    
    public func getSize(for font: UIFont, maxSize: CGSize) -> CGSize {
        let attribute = NSMutableDictionary()
        attribute.setValue(font, forKey: NSAttributedString.Key.font.rawValue)
        let size = wrappedValue.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attribute as? [NSAttributedString.Key: Any], context: nil).size
        return size
    }
}

