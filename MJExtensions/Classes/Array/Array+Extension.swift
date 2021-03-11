//
//  Array+Extension.swift
//  MJExtensions
//
//  Created by chenminjie on 2021/1/22.
//

import Foundation

extension Array: NamespaceWrappable { }
public extension TypeWrapperProtocol where WrappedType == Array<[String: Any]> {
    
    var jsonString: String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: wrappedValue, options: []);
            let JSONString = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
            return JSONString;
        } catch {
            
        }
        return nil;

    }
}
