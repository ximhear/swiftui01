//
//  StringTest.swift
//  SwiftUI01
//
//  Created by we on 2023/06/16.
//

import SwiftUI
import Foundation
import System
import RegexBuilder

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
        
        //TODO: init(unsafeUninitializedCapacity:initializingUTF8With:)
        initializingUTF8With()
        
        //TODO: init(_ scalar: Unicode.Scalar)
        logger.log(String(Unicode.Scalar.init(65)))
//        logger.log(String(Unicode.Scalar(unicodeScalarLiteral: "🌍")))
//        let unicodeScalar: Unicode.Scalar = "🌍"
//        logger.log(unicodeScalar)
        
        //TODO: init(data:encoding:)
        if let data = name.data(using: .utf8),
           let str = String.init(data: data, encoding: .utf8) {
            logger.log(str)
        }
        
        //TODO: init(validatingUTF8:)
        initValidatingUTF8()
       
        //TODO: init(utf16CodeUnits:count:)
        initUtf16CodeUnits()
        
        //TODO: init(decoding:as:)
        initDecodingAs()
        
        //TODO: https://developer.apple.com/documentation/swift/string#creating-a-string-using-formats
        //TODO: init(format:_:)
        initFormat()
        
        //TODO: init(bytes:encoding:)
        initBytesEncoding()
        
        //TODO: init(cString:)
        initCString()
        
        //TODO: LosslessStringConvertible
        logger.log(String(LosslessArray.init(array: [1, 2])))
        
        //TODO: TextOutputStreamable
        logger.log(Int(10) is TextOutputStreamable)
        logger.log("String" is TextOutputStreamable)
        logger.log(String(describing: TextOutputStreamableArray.init(array: ["1", "2"])))
        
        //TODO: CustomStringConvertible
        logger.log(String(describing: Int(100) as CustomStringConvertible))
        
        //TODO: CustomStringConvertible, TextOutputStreamable, CustomDebugStringConvertible
        logger.log(String(describing: Ggg(value: 123)))
        //TODO: reflecting, 아마도 CustomDebugStringConvertible 우선
        logger.log(String(reflecting: Ggg(value: 123)))
        
        //TODO: https://developer.apple.com/documentation/swift/string#creating-a-string-from-a-file-or-url
        //TODO: init(contentsOf:)
        initContentOf()
        
        //TODO: write
        write()
        
        //TODO: append
        append()
        
        logger.log("string" is any Sequence)
        logger.log("string" + ["s", "u"])
        logger.log(["s", "u"] + "string")
        breakTimeForSequence()
        
        //TODO: insert
        insert()
        
        //TODO: Replacing Substrings
        replaceSubstring()
        
        //TODO: Removing Substrings
        removeSubstring()
        
        //TODO: Changing Case
        logger.log(str.lowercased())
        logger.log(str.uppercased())
        
        //TODO: Comparing Strings Using Operators
        compareString()
        
        //TODO: Comparing Characters
        compareCharacters()
        
        //TODO: Creating and Applying Differences
        differencesApplying()
        
        logger.log(str)
        logger.log(str.hasPrefix("The ra"))
        logger.log(str.hasSuffix("he plain."))
        
        //TODO: Finding Characters
        findCharacters()
        
    }
    
    private func findCharacters() {
        
        let str = "This example checks to see whether a favorite actor is in an array storing a movie’s cast."
        logger.log(str.contains("movie"))
        do {
            let regex = try Regex("^this")
            logger.log(str.contains(regex))
            let regex1 = try Regex("This")
            logger.log(str.contains(regex1))
        }
        catch {
            logger.log(error)
        }
        
        var digit = "1234567890"
        var result = digit.allSatisfy { c in
            c.isNumber
        }
        logger.log(result)
        logger.log(digit.contains { $0.isLetter })
        
        digit = "123Hello"
        result = digit.allSatisfy { $0.isNumber }
        logger.log(result)
        result = digit.contains {
            return $0.isLetter
        }
        logger.log(result)
        
        let c = digit.first {
            $0.isLetter
        }
        logger.log(c)
        
        var index = digit.firstIndex(of: "H")
        logger.log(index)
        let str2 = "Caféééééé"
        let index1 = str2.firstIndex(of: "é")
        logger.log(index1)
        logger.log(index1?.samePosition(in: str2.utf8))
        logger.log(index1?.samePosition(in: str2.utf16))
        if let index2 = index1?.samePosition(in: str2.utf16) {
            logger.log(String(str2.utf16[index2...]))
        }
        if let index2 = index1?.samePosition(in: str.utf16) {
            logger.log(String(str.utf16[index2...]))
        }
        
        if let index = digit.firstIndex(where: { $0.isLetter }) {
            logger.log(digit[index...])
        }
        
        if let index = str2.lastIndex(of: "f") {
            logger.log(str2[...index])
        }
        
        if let index = digit.lastIndex(where: { $0.isNumber }) {
            logger.log(digit[...index])
        }
        
    }
    
    func differencesApplying() {
        let str1 = "hello"
        let str2 = "hello호"
        let diff = str1.difference(from: str2)
        logger.log(diff.insertions)
        logger.log(diff.removals)
        let inversed = diff.inverse()
        logger.log(inversed.insertions)
        logger.log(inversed.removals)
        
        let str3 = "ABCDEFGHIJK"
        let str4 = str3.applying(diff)
        let str5 = str3.applying(inversed)
        logger.log(str3)
        logger.log(str4)
        logger.log(str5)
        
        let str6 = "GGG"
        let str7 = str6.applying(diff)
        let str8 = str6.applying(inversed)
        logger.log(str6)
        logger.log(str7)
        logger.log(str8)
        
        let a = [1, 2, 11, 22]
        let b = [1, 2, 3, 4]
        let c = [100, 200, 300, 400, 500, 600]
        let diff1 = a.difference(from: b)
        logger.log(diff1.insertions)
        logger.log(diff1.removals)
        let d = c.applying(diff1)
        logger.log(d)
    }
    
    func compareCharacters() {
        let str1 = "Cafe\u{301}"
        let str2 = "Café"
        let str3 = "Caf\u{00E9}"
        logger.log(str1.elementsEqual(str2))
        logger.log(str1.elementsEqual(str3))
        let chars = str2.map { $0 }
        let chars1 = str1.unicodeScalars.map { $0.value }.compactMap { Unicode.Scalar($0) }.map { Character($0) }
        let chars2 = str2.unicodeScalars.map { $0.value }.compactMap { Unicode.Scalar($0) }.map { Character($0) }
        let chars3 = str3.unicodeScalars.map { $0.value }.compactMap { Unicode.Scalar($0) }.map { Character($0) }
        logger.log(chars)
        logger.log(chars1)
        logger.log(chars2)
        logger.log(chars3)
        
        logger.log(str1.elementsEqual(chars))
        logger.log(str2.elementsEqual(chars))
        logger.log(str3.elementsEqual(chars))
        
        logger.log(str1.elementsEqual(chars1))
        logger.log(str1.elementsEqual(chars3))
        
        logger.log(chars.elementsEqual(chars3))
        logger.log(chars1.elementsEqual(chars3))
        
        logger.log(str1[str1.index(before: str1.endIndex)])
        logger.log(str2[str2.index(before: str2.endIndex)])
        logger.log(str3[str3.index(before: str3.endIndex)])
        
        logger.log(str1[str1.index(before: str1.endIndex)].unicodeScalars.count)
        logger.log(str2[str2.index(before: str2.endIndex)].unicodeScalars.count)
        logger.log(str3[str3.index(before: str3.endIndex)].unicodeScalars.count)
        
        let lower = "hello nice"
        let upper = "HELLO NICE"
        let r1 = lower.elementsEqual(upper) { c1, c2 in
            c1.lowercased() == c2.lowercased()
        }
        logger.log(r1)
        do {
            let r = try lower.elementsEqual(upper) { c1, c2 in
                throw "elementsEqual error"
            }
            logger.log(r)
        } catch {
            logger.log(error)
        }

        let koreanFlag = "\u{1F1F0}\u{1F1F7}"
        logger.log(koreanFlag)
        logger.log(koreanFlag.count)
        logger.log(koreanFlag.unicodeScalars.count)
        
        logger.log([1, 2, 3].elementsEqual([1, 2, 3]))
        
        logger.log(str1.starts(with: "Caf"))
        logger.log(str1.starts(with: ""))
       
        do {
            let simpleDigits = try Regex("C")
            logger.log(str1.starts(with: simpleDigits))
            logger.log(str1.starts(with: RegexBuilder.Anchor.startOfLine))
            logger.log(str1.starts(with: CharacterClass.generalCategory(.lowercaseLetter)))
            
            let str1 = "ABCDEFGHIJK"
            let str2 = "abc"
            let r = str1.starts(with: str2) { c1, c2 in
                c1 == c2
            }
            logger.log(r)
            let r1 = str1.starts(with: str2) { c1, c2 in
                c1.lowercased() == c2.lowercased()
            }
            logger.log(r1)
        } catch {
            logger.log(error)
        }
        
        let a = [1, 2, 2, 2]
        let b = [1, 2, 3, 4]
        logger.log(a.lexicographicallyPrecedes(b))
        logger.log(b.lexicographicallyPrecedes(b))
        logger.log(str1.lexicographicallyPrecedes(str3))
        logger.log(str3.lexicographicallyPrecedes(str1))
        logger.log(str1.unicodeScalars.map { $0.value })
        logger.log(str3.unicodeScalars.map { $0.value })
        logger.log(chars1.lexicographicallyPrecedes(chars3))
    }


    func compareString() {
        let str1 = "Cafe\u{301}"
        let str2 = "Café"
        logger.log(str1 == str2)
        
        let str3 = str2[str2.startIndex...]
        logger.log(type(of: str3))
        logger.log(str1 == str3)
        
        var str = "helloggg"
        logger.log(str ~= "h")
        logger.log(0...10 ~= 3)
        logger.log(5 ~= 5)
    }
    
    func removeSubstring() {
        var str = "01234567890123456789"
        var index = str.index(after: str.startIndex)
        str.remove(at: index)
        logger.log(str)
        
        str.removeAll()
        logger.log(str)
        
        str = "01234567890123456789"
        str.removeAll(where: { $0 == "1" })
        logger.log(str)
        
        str.removeFirst()
        logger.log(str)
        
        str.removeFirst(3)
        logger.log(str)
        
        str.removeLast()
        logger.log(str)
        
        str.removeLast(4)
        logger.log(str)
        
        str = "01234567890123456789"
        index = str.index(str.startIndex, offsetBy: 4)
        str.removeSubrange(str.startIndex..<index)
        logger.log(str)
        
        str.removeSubrange(..<index)
        logger.log(str)
        
        str.removeSubrange(str.index(str.startIndex, offsetBy: 2)...)
        logger.log(str)
        
        str = "01234567890123456789"
        logger.log(str.filter({ $0 > "5" }))
        
        str = "01234567890123456789"
        logger.log(str.filter({ $0 < "5" }))
        
        str = "01234567890123456789"
        logger.log(str.drop(while: { $0 < "5" }))
        
        str = "01234567890123456789"
        logger.log(str.drop(while: { $0 > "5" }))
        
        str = "01234567890123456789"
        logger.log(str.dropFirst(5))
        logger.log(str)
        
        str = "01234567890123456789"
        logger.log(str.dropLast(5))
        logger.log(str)
        
        str = "01234567890123456789"
        while str.count > 0 {
            if let c = str.popLast() {
                logger.log(str)
            }
        }
    }
    
    func replaceSubstring() {
        var str = "0123456789"
        str.replaceSubrange(str.startIndex..<str.index(str.startIndex, offsetBy: 3), with: "AAA")
        logger.log(str)
        
        str = "0123456789"
        str.replaceSubrange(str.startIndex..<str.index(str.startIndex, offsetBy: 3), with: "AB")
        logger.log(str)
        
        str = "0123456789"
        str.replaceSubrange(str.startIndex..<str.index(str.startIndex, offsetBy: 3), with: "ABCD")
        logger.log(str)
        
        if let endIndex = str.index(str.startIndex, offsetBy: 100, limitedBy: str.endIndex) {
            logger.log(endIndex)
        }
        
        str = "0123456789"
        str.replaceSubrange(..<str.index(str.startIndex, offsetBy: 3), with: "ABCD")
        logger.log(str)
        
        str = "0123456789"
        str.replaceSubrange(...str.index(str.startIndex, offsetBy: 3), with: "ABCD")
        logger.log(str)
        
        str = "0123456789"
        str.replaceSubrange(str.index(str.startIndex, offsetBy: 3)..., with: "ABCD")
        logger.log(str)
    }
    
    func insert() {
        var str = "0123456789"
        logger.log(str is any Collection)
        str.insert("C" as Character, at: str.endIndex)
        logger.log(str)
        str.insert(contentsOf: "DD", at: str.endIndex)
        logger.log(str)
        str.insert(contentsOf: "FF", at: str.endIndex)
        logger.log(str)
        str.insert(contentsOf: ["E", "E"], at: str.endIndex)
        logger.log(str)
        
    }
    
    func breakTimeForSequence() {
        logger.log((6...10) + [1,2,3])
        logger.log((6...10) is any Sequence)
        logger.log([1, 2, 3] is any Sequence)
        logger.log(["A": 32] is any Sequence)
        logger.log([String: String].Element.self)
        logger.log(type(of: ["A": 32, 12: "good"]))
        logger.log(["A": 32, 12: "good"] + [(key: "now", value: Date.now)])
        logger.log(type(of: ["A": 32, 12: "good"] + [(key: "now", value: Date.now)]))
        
        struct ETest: Sequence {
            typealias Element = (key: Int, value: String)

            let dictionary: [Int: String]

            func makeIterator() -> AnyIterator<Element> {
                var iterator = dictionary.makeIterator()
                return AnyIterator {
                    return iterator.next()
                }
            }
        }
        logger.log(ETest(dictionary: [100: "100"]).makeIterator())
        let rr = ETest(dictionary: [100: "100", 300: "330"]) + [(key: 200, value: "200")]
        logger.log(type(of: rr))
        logger.log(rr)
        
        let s = MyCustomSequence(value: (key: 900, value: "900"))
        let ss = s + [(key: 200, value: "200")]
        logger.log(ss)
        
        let s1 = MyCustomIntSequence(value: (key: 100, value: "100"))
        let ss1 = s1 + [(key: 300, value: "300")]
        logger.log(ss1)
        
        func printSequence(_ sequence: any Sequence) {
            var it = sequence.makeIterator() as any IteratorProtocol
            var vv = it.next()
            while vv != nil {
                logger.log(vv)
                vv = it.next()
            }
        }
        
        var s3: [Int: String] = [300: "300", 400: "400"]
        printSequence(s3)
        
        let s4 = [1, 2, 3]
        printSequence(s4)
    }
    
    func append() {
       var str = "Today is "
        str.append("\(Date.now.description(with: .init(identifier: "ko-KR")))")
        logger.log(str)
        
        var globe = "Globe "
        logger.log(globe.utf8CString.capacity)
        globe.append(Character("🌍"))
        logger.log(globe)
        
        globe.append(contentsOf: "ggg")
        logger.log(globe)
        
        let sub = str[str.startIndex..<str.index(str.startIndex, offsetBy: 5)]
        globe.append(contentsOf: sub)
        logger.log(globe)
         
        let chrs = [Character("a"), Character("b")]
        globe.append(contentsOf: chrs)
        logger.log(globe)
        
        for _ in 0..<2 {
            globe.append(Character("🌍"))
            logger.log("\(globe.utf8.count) - \(globe.utf8CString.capacity)")
        }
        
        globe.reserveCapacity(128)
        
        for _ in 0..<2 {
            globe.append(Character("🌍"))
            logger.log("\(globe.utf8.count) - \(globe.utf8CString.capacity)")
        }
        
        logger.log(globe.utf8CString)
    }
    
    func write() {
        var str = "Hello"
        str.write(", friend")
        logger.log(str)
        
        var a = TextOutputStreamArray(array: [1, 2])
        "ggg".write(to: &a)
        logger.log(String(describing: a))
    }
    
    func initContentOf() {
        guard let url = Bundle.main.url(forResource: "Test", withExtension: "txt") else {
            return
        }
        logger.log(url.absoluteString)
        do {
            let str = try String.init(contentsOf: url)
            logger.log(str)
            let str1 = try String.init(contentsOf: url, encoding: .utf8)
            logger.log(str1)
            let str2 = try String.init(contentsOf: url, encoding: .ascii)
            logger.log(str2)
            var encoding: String.Encoding = .isoLatin1
            let str3 = try String.init(contentsOf: url, usedEncoding: &encoding)
            logger.log(encoding)
            logger.log(str3)
        }
        catch {
            logger.log(error)
        }
    }
    
    func initCString() {
        // CChar == Int8
        let validUTF8: [CChar] = [67, 97, 102, -61, -87, 0]
        validUTF8.withUnsafeBufferPointer { p in
            logger.log(type(of: p))
            if let cstr = p.baseAddress {
                logger.log(type(of: cstr))
                logger.log(String.init(cString: cstr))
                
                cstr.withMemoryRebound(to: UInt8.self, capacity: p.count) { pointer in
                    logger.log(type(of: pointer))
                    logger.log(String.init(cString: pointer))
                }
            }
        }
        validUTF8.withUnsafeBufferPointer { ptr in
            let s = String(cString: ptr.baseAddress!)
            print(s)
        }
        // Prints "Café"


        let invalidUTF8: [CChar] = [67, 97, 102, -61, 0]
        invalidUTF8.withUnsafeBufferPointer { p in
            if let cstr = p.baseAddress {
                logger.log(String.init(cString: cstr))
            }
        }
        invalidUTF8.withUnsafeBufferPointer { ptr in
            let s = String(cString: ptr.baseAddress!)
            print(s)
        }
        // Prints "Caf�"
        
        
    }
    
    func initBytesEncoding() {
        logger.log(String(bytes: [65, 66, 67], encoding: .ascii))
        logger.log(String(bytes: [65, 66, 67], encoding: .utf8))
        
        let str = "Cafe\u{301} 🌍 Marie Curie"
        logger.log(Array(str.utf8))
        logger.log(String(bytes: Array(str.utf8), encoding: .ascii))
        logger.log(String(bytes: Array(str.utf8), encoding: .utf8))
        
        //TODO: 16 bit 유니코드를 8 bit 배열에 넣고, 이를 utf16으로 디코딩시켜본다.
        logger.log(Array(str.utf16))
        logger.log(Array(str.utf16).map { $0.bigEndian })
        Array(str.utf16).withUnsafeBytes { rp in
            logger.log(type(of: rp))
            logger.log(rp is (any Sequence))
            logger.log(String(bytes: rp, encoding: .utf16))
        }
        //TODO: 기본이 little endian이어서 big endian으로 바이트 순서를 바꾸니 제대로 나온다.
        Array(str.utf16).map { $0.bigEndian }.withUnsafeBytes { rp in
            logger.log(rp[0])
            logger.log(rp[1])
            logger.log(rp[8])
            logger.log(rp[9])
            logger.log(String(bytes: rp, encoding: .utf16))
        }
    }
    
    func initFormat() {
        logger.log(String(format: "%d", Int32(10)))
        logger.log(String(format: "%d", Int64(11)))
        logger.log(String(format: "%f", Float(12)))
        logger.log(String(format: "%f", Double(13)))
        logger.log(String(format: "%.3f", Double(13)))
        logger.log(String(format: "%@", String("100")))
        logger.log(String(format: "%03d", Int32(10)))
        logger.log(String(format: "%p", Int32(8)))
        logger.log(String(format: "%p", Int32(0xA18)))
        let hexStr = String(0xA88924E3F, radix: 16, uppercase: true)
        logger.log(hexStr)
        let paddedHexStr: String
        if hexStr.count % 2 == 0 {
           paddedHexStr = hexStr
        }
        else {
            paddedHexStr = "0" + hexStr
        }
        logger.log(paddedHexStr)
        let arr = Array(paddedHexStr)
        logger.log(arr)
        
        var index = paddedHexStr.startIndex
        while index < paddedHexStr.endIndex {
            let temp = paddedHexStr.index(index, offsetBy: 2)
            let str = paddedHexStr[index..<temp]
            logger.log(str)
            index = temp
        }
        
        logger.log(String(format: "%d - %d - %d", arguments: [1, 2, 3]))
        logger.log(Locale.current)
        logger.log(String.init(format: "%d %@", locale: .current, 10, Date.now as CVarArg))
        let l = Locale.init(identifier: "ko_KR")
        logger.log(String.init(format: "%d %@", locale: l, 10, Date.now as CVarArg))
        
        var components = Locale.Components(languageCode: "ko", languageRegion: "KR")
        components.calendar = Calendar.Identifier.buddhist
        logger.log(Locale.Collation.availableCollations.map { $0.identifier } )
        components.collation = Locale.Collation("compact")
        components.hourCycle = Locale.HourCycle.oneToTwentyFour
        components.timeZone = TimeZone(identifier: "America/Los_Angeles")
        components.region = Locale.Region("US")
        let l1 = Locale(components: components)
        logger.log(String.init(format: "%d %@", locale: l1, 10, Date.now as CVarArg))
        logger.log(String.localizedStringWithFormat("%@", Date.now as CVarArg))
        logger.log("\(Date.now)")
    }
    
    func initDecodingAs() {
        let str = "🌍 Marie Curie"
        let scalars = str.unicodeScalars.map( {$0} )
        // 어떻게 init를 사용하지는 모르겠음.
    }
    
    func initUtf16CodeUnits() {
        let str = "🌍 Marie Curie"
        let arr = str.utf16.map { $0 }
        logger.log(type(of: arr))
        logger.log(String.init(utf16CodeUnits: arr, count: arr.count))
    }
    
    func initValidatingUTF8() {
//        let validUTF8: [UInt8] = [0x43, 0x61, 0x66, 0xC3, 0xA9]
        let c: CChar = -61
        let uc: UInt8 = .init(bitPattern: c)
        logger.log(255 - 61 + 1)
        logger.log(uc)
        logger.log(0xC3)
        logger.log(0xA9)
        let validUTF8: [CChar] = [67, 97, 102, -61, -87, 0]
        logger.log(String(validatingUTF8: validUTF8))
        validUTF8.withUnsafeBytes { urbp in
            if let p = urbp.baseAddress?.bindMemory(to: CChar.self, capacity: urbp.count) {
                logger.log(String(validatingUTF8: p))
            }
        }
        validUTF8.withUnsafeBufferPointer { ubp in
            if let p = ubp.baseAddress {
                logger.log(String(validatingUTF8: p))
            }
        }
        validUTF8.withUnsafeBufferPointer { ptr in
            let s = String(validatingUTF8: ptr.baseAddress!)
            logger.log(s)
        }
        // Prints "Optional("Café")"


        let invalidUTF8: [CChar] = [67, 97, 102, -61, 0]
        invalidUTF8.withUnsafeBufferPointer { ptr in
            let s = String(validatingUTF8: ptr.baseAddress!)
            logger.log(s)
        }
        // Prints "nil"
    }
    
    func initializingUTF8With() {
        let validUTF8: [UInt8] = [0x43, 0x61, 0x66, 0xC3, 0xA9]
        let invalidUTF8: [UInt8] = [0x43, 0x61, 0x66, 0xC3]
        
        let str = String.init(unsafeUninitializedCapacity: validUTF8.count) { umbp in
            logger.log(umbp.count)
            let _ = umbp.initialize(from: validUTF8)
            return validUTF8.count
        }
        logger.log(str)

        let cafe1 = String(unsafeUninitializedCapacity: validUTF8.count) {
            _ = $0.initialize(from: validUTF8)
            return validUTF8.count
        }
        logger.log(cafe1)
        // cafe1 == "Café"


        let cafe2 = String(unsafeUninitializedCapacity: invalidUTF8.count) {
            _ = $0.initialize(from: invalidUTF8)
            return invalidUTF8.count
        }
        logger.log(cafe2)
        // cafe2 == "Caf�"


        let empty = String(unsafeUninitializedCapacity: 16) { _ in
            // Can't initialize the buffer (e.g. the capacity is too small).
            return 0
        }
        logger.log(empty)
        // empty == ""
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

struct LosslessArray<T: LosslessStringConvertible>: LosslessStringConvertible {
    var description: String {
        return array.map { $0.description }.joined(separator: ", ")
    }

    let array: [T]

    init?(_ description: String) {
        self.array = description.components(separatedBy: ",").compactMap{ T($0) }
    }

    init(array: [T]) {
        self.array = array
    }
}

fileprivate struct TextOutputStreamableArray<T: TextOutputStreamable>: TextOutputStreamable {
    
    let array: [T]
    
    init(array: [T]) {
        self.array = array
    }
    
    func write<Target>(to target: inout Target) where Target : TextOutputStream {
        for x in array {
            x.write(to: &target)
            x.write(to: &target)
        }
    }
}

fileprivate struct Ggg: TextOutputStreamable, CustomStringConvertible, CustomDebugStringConvertible {
    var debugDescription: String {
        "debug \(value.description)"
    }
    
    let value: Int
    func write<Target>(to target: inout Target) where Target : TextOutputStream {
        target.write(String(value))
        target.write(String(value))
        target.write(String(value))
    }
    
    var description: String {
        value.description
    }
}

fileprivate struct TextOutputStreamArray: TextOutputStream, TextOutputStreamable {
    
    var array: [CustomStringConvertible]
    mutating func write(_ string: String) {
        array.append(string as CustomStringConvertible)
    }
    
    func write<Target>(to target: inout Target) where Target : TextOutputStream {
        for x in array {
            target.write(x.description)
        }
    }
}

extension String: Error {
    
}
