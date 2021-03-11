//
//  Dictionary+Extension.swift
//  MJExtensions
//
//  Created by chenminjie on 2021/1/22.
//

import Foundation

extension Dictionary: NamespaceWrappable { }
public extension TypeWrapperProtocol where WrappedType == Dictionary<String, Any> {
    
    var jsonString: String? {
        if let dict = (wrappedValue as AnyObject) as? [String: AnyObject] {
            do {
                let data = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions(rawValue: 0))
                if let string = String(data: data, encoding: String.Encoding.utf8) {
                    return string
                }
            } catch {
                
            }
        }
        return nil
    }
}
