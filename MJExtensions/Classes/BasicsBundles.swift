//
//  BasicsBundles.swift
//  MJExtension
//
//  Created by chenminjie on 2020/11/7.
//

import Foundation

/// 自定义的一些扩展的命名空间，用于防止和第三方冲突

public protocol NamespaceWrappable {
    associatedtype WrapperType
    var ext: WrapperType { get }
    static var ext: WrapperType.Type { get }
}

public extension NamespaceWrappable {
    var ext: NamespaceWrapper<Self> {
        get { return NamespaceWrapper(value: self) }
        set { }
    }

    static var ext: NamespaceWrapper<Self>.Type {
        return NamespaceWrapper.self
    }
}

public protocol TypeWrapperProtocol {
    associatedtype WrappedType
    var wrappedValue: WrappedType { get }
    init(value: WrappedType)
}

public struct NamespaceWrapper<T>: TypeWrapperProtocol {
    public let wrappedValue: T
    public init(value: T) {
        self.wrappedValue = value
    }
}

extension NSObject: NamespaceWrappable { }
