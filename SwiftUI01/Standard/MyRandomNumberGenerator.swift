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
