//
//  MyCustomSequence.swift
//  SwiftUI01
//
//  Created by we on 2023/06/21.
//

import Foundation

struct MyCustomSequence<Key, Value>: Sequence where Key: Hashable {
    typealias Element = (key: Key, value: Value)
    
    let value: Element
    
    struct MyCustomIterator: IteratorProtocol {
        typealias Element = MyCustomSequence.Element
        let v: Element
        var index: Int = 0
        mutating func next() -> MyCustomSequence<Key, Value>.Element? {
            if index == 0 {
                index += 1
                return v
            }
            return nil
        }
    }
    
    func makeIterator() -> MyCustomIterator {
        return MyCustomIterator(v: value)
        
    }
}

struct MyCustomIntSequence<Value: CustomStringConvertible>: Sequence {
    typealias Element = (key: Int, value: Value)
    
    let value: Element
    
    struct MyCustomIntIterator: IteratorProtocol {
        typealias Element = MyCustomIntSequence.Element
        let v: Element
        var index: Int = 0
        mutating func next() -> MyCustomSequence<Int, Value>.Element? {
            if index < 5  {
                defer {
                    index += 1
                }
                return (key: v.key + index, value: (String(describing: v.value) + "- \(index)") as! Value)
            }
            return nil
        }
    }
    
    func makeIterator() -> MyCustomIntIterator {
        return MyCustomIntIterator(v: value)
        
    }
}
