//
//  StringComparator.swift
//  SwiftUI01
//
//  Created by we on 2023/06/26.
//

import Foundation

class StringComparator: SortComparator {
    init(order ord: SortOrder) {
        order = ord
    }
    static func == (lhs: StringComparator, rhs: StringComparator) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func compare(_ lhs: Character, _ rhs: Character) -> ComparisonResult {
        if lhs < rhs {
            return .orderedAscending
        }
        if lhs == rhs {
            return .orderedSame
        }
        return .orderedDescending
    }
    
    typealias Compared = Character
    
    //TODO: Order를 단순히 forward, reverse로 하는 것으로는 순서가 바뀌지 않는 것같다.
    var order: SortOrder
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(order)
    }
}

class IntComparator: SortComparator {
    
    init(order ord: SortOrder) {
        order = ord
    }
    static func == (lhs: IntComparator, rhs: IntComparator) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func compare(_ lhs: Int, _ rhs: Int) -> ComparisonResult {
        if lhs < rhs {
            return .orderedAscending
        }
        if lhs == rhs {
            return .orderedSame
        }
        return .orderedDescending
    }
    
    typealias Compared = Int
    
    var order: SortOrder
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(order)
    }
}
