//
//  Data+Extension.swift
//  MJExtension
//
//  Created by chenminjie on 2020/11/7.
//

import Foundation
import CommonCrypto
import CryptoSwift

extension TypeWrapperProtocol where WrappedType == Data {
    
    public var md5String: String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        #if swift(>=5.0)
        _ = wrappedValue.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
            return CC_MD5(bytes.baseAddress, CC_LONG(wrappedValue.count), &digest)
        }
        #else
        _ = data.withUnsafeBytes { bytes in
            return CC_MD5(bytes, CC_LONG(wrappedValue.count), &digest)
        }
        #endif
        
        return digest.reduce(into: "") { $0 += String(format: "%02x", $1) }
    }
}
