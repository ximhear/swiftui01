//
//  MyRandomNumberGenerator.swift
//  SwiftUI01
//
//  Created by gzonelee on 2023/06/23.
//

import Foundation

struct MyRandomNumberGenerator: RandomNumberGenerator {
    
    func next() -> UInt64 {
        return UInt64.random(in: 0..<UInt64.max)
    }
}

struct MyPseudoRandomNumberGenerator: RandomNumberGenerator {
    var value: UInt64
    
    mutating func next() -> UInt64 {
        let v = value.multipliedReportingOverflow(by: value).partialValue
        value &+= v + 1
        print("value : \(value)")
        return value
    }
}
