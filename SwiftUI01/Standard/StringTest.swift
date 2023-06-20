//
//  StringTest.swift
//  SwiftUI01
//
//  Created by we on 2023/06/16.
//

import SwiftUI
import Foundation
import System

struct StringTest: View {
    @ObservedObject var logger: Logger = .init()
    var body: some View {
        List {
            ForEach(logger.logs.reversed(), id: \.self) { log in
                Text(log)
            }
        }
        .onAppear {
            test()
        }
    }
    
    func test() {
        let banner = """
                  __,
                 (           o  /) _/_
                  `.  , , , ,  //  /
                (___)(_(_/_(_ //_ (__
                             /)
                            (/
                """
        logger.addLog(banner)
        logger.addLog("""
    c
    aaa
    b
    """)
        logger.addLog("""
        c
        aaa
        b
    """)
        
        let cafe1 = "Cafe\u{301}"
        let cafe2 = "Café"
        logger.addLog(cafe1 == cafe2)
        
        var name = "Marie Curie"
        var firstSpace = name.firstIndex(of: " ") ?? name.endIndex
        var firstName = name[..<firstSpace]
        logger.addLog(firstName)
        
        let cafe = "Cafe\u{301} du 🌍"
        logger.addLog(cafe)
        logger.addLog(cafe.count)
        // Prints "9"
        logger.addLog(Array(cafe))
        
        //TODO: UTF-32
        logger.addLog(cafe.unicodeScalars.count)
        logger.addLog(cafe.unicodeScalars)
        logger.addLog(Array(cafe.unicodeScalars))
        logger.addLog(cafe.unicodeScalars.map { $0.value })
        
        //TODO: UTF-16
        logger.addLog(cafe.utf16.count)
        logger.addLog(cafe.utf16)
        logger.addLog(Array(cafe.utf16))
        logger.addLog(cafe.utf16.map { $0 })
        
        let nscafe = cafe as NSString
        logger.addLog(nscafe.length)
        logger.addLog(nscafe.character(at: 3))
        
        //TODO: UTF-8
        logger.addLog(cafe.utf8.count)
        logger.addLog(cafe.utf8)
        logger.addLog(Array(cafe.utf8))
        logger.addLog(cafe.utf8.map { $0 })
        
        let cLength = strlen(cafe)
        logger.addLog(cLength)
        var utf8map = cafe.utf8.map { $0 }
        logger.addLog(type(of: utf8map))
        utf8map.withUnsafeBytes { urbp in
            if let urp = urbp.baseAddress {
                let up = urp.bindMemory(to: Int8.self, capacity: utf8map.count)
                logger.addLog(strlen(up))
            }
        }
        
        let flag = "🇵🇷"
        logger.addLog(flag.count)
        // Prints "1"
        logger.addLog(Array(flag.unicodeScalars))
        logger.addLog(flag.unicodeScalars.count)
        // Prints "2"
        logger.addLog(Array(flag.utf16))
        logger.addLog(flag.utf16.count)
        // Prints "4"
        logger.addLog(Array(flag.utf8))
        logger.addLog(flag.utf8.count)
        // Prints "8"
        
        //TODO: https://developer.apple.com/documentation/swift/string#Accessing-String-View-Elements
        name = "Cafe\u{301} du 🌍 Marie Curie"
        firstSpace = name.firstIndex(of: " ") ?? name.endIndex
        firstName = name[..<firstSpace]
        logger.addLog(firstSpace)
        logger.addLog(firstName)
        logger.addLog(name.unicodeScalars[..<firstSpace].map { $0.value })
        logger.addLog(name.utf16[..<firstSpace].map { $0 })
        logger.addLog(name.utf8[..<firstSpace].map { $0 })
        
        let firstCodeUnit = flag.startIndex
        let secondCodeUnit = flag.utf8.index(after: firstCodeUnit)
        logger.addLog(firstCodeUnit)
        logger.addLog(secondCodeUnit)
        logger.addLog(flag.utf8[firstCodeUnit])
        logger.addLog(flag.utf8[secondCodeUnit])
        logger.addLog(flag.utf16[firstCodeUnit])
        logger.addLog(flag.utf16[secondCodeUnit])
        logger.addLog(String(flag.unicodeScalars[firstCodeUnit].value, radix: 16))
        logger.addLog(flag.unicodeScalars[firstCodeUnit].value)
        logger.addLog(flag.unicodeScalars[secondCodeUnit].value)
        logger.addLog(flag[firstCodeUnit])
        logger.addLog(flag[secondCodeUnit])
        if let exactIndex = firstCodeUnit.samePosition(in: flag) {
            logger.addLog(flag[exactIndex])
        } else {
            logger.addLog("No exact match for this position.")
        }
        if let exactIndex = String.Index.init(firstCodeUnit, within: flag) {
            logger.addLog(flag[firstCodeUnit])
        }
        else {
            logger.addLog("No exact match for this position.")
        }
        if let exactIndex = String.Index.init(secondCodeUnit, within: flag) {
            logger.addLog(flag[exactIndex])
        }
        else {
            logger.addLog("No exact match for this position.")
        }
        if let exactIndex = secondCodeUnit.samePosition(in: flag) {
            logger.addLog(flag[exactIndex])
        } else {
            logger.addLog("No exact match for this position.")
        }
        if let exactIndex = String.Index(secondCodeUnit, within: flag.utf8) {
            logger.addLog(flag[exactIndex])
        } else {
            logger.addLog("No exact match for this position.")
        }
        if let exactIndex = String.Index(secondCodeUnit, within: flag.utf16) {
            logger.addLog(flag[exactIndex])
        } else {
            logger.addLog("No exact match for this position.")
        }
        
        //TODO: init
        let path = FilePath(stringLiteral: "/Users/we/Downloads/hi.txt")
        logger.addLog(String.init(decoding: path))
        logger.addLog(String())
        logger.addLog(Character("C"))
        logger.addLog(String(flag.utf8))
        
        let str = "The rain in Spain stays mainly in the plain."
        let vowels: Set<Character> = ["a", "e", "i", "o", "u"]
        let disemvoweled = String(str.lazy.filter { !vowels.contains($0) })
        logger.addLog(disemvoweled)
        
        let temp01 = ["1", "2", "345"]
        let temp02 = LosslessStringArray(array: temp01)
        let temp03: [Character] = ["1", "2", "3"]
        logger.addLog(type(of: temp01))
        logger.addLog(temp01 is CustomStringConvertible)
        logger.addLog(temp02 is LosslessStringConvertible)
        logger.addLog(temp03 is LosslessStringConvertible)
        logger.addLog(temp03 is (any Sequence))
        logger.addLog("Hello" is LosslessStringConvertible)
        logger.addLog("Hello" is (any Sequence))
        //TODO: init<T>(_ value: T) where T : LosslessStringConvertible
        logger.addLog(String.init(temp02))
        //TODO: init<S>(_ other: S) where S : LosslessStringConvertible, S : Sequence, S.Element == Character
        logger.addLog(String.init("Hello"))
        
        var subStr = str[..<str.index(str.startIndex, offsetBy: 5)]
        logger.addLog(type(of: subStr))
        logger.addLog(subStr)
        logger.addLog(String.init(subStr))
        logger.addLog(String.init(repeating: "Hello", count: 3))
        logger.addLog(String.init(repeating: Character("C"), count: 3))
        logger.addLog(String.init(repeating: "C" as Character, count: 3))
    }
}

struct StringTest_Previews: PreviewProvider {
    static var previews: some View {
        StringTest()
    }
}

struct LosslessStringArray: LosslessStringConvertible {
    var description: String {
        return array.joined(separator: ",")
    }

    let array: [String]

    init?(_ description: String) {
        self.array = description.components(separatedBy: ",")
    }

    init(array: [String]) {
        self.array = array
    }
}

