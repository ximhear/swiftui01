//
//  ArrayTest.swift
//  SwiftUI01
//
//  Created by we on 2023/06/26.
//

import SwiftUI

struct ArrayTest: View {
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
    
    private func test() {
        //TODO: Creating an Array
        createArray()
        
        //TODO: Adding Elements
        addElements()
        
        //TODO: Combining Arrays
        combineArrays()
        
        //TODO: Removing Elements
        removeElements()
        
        //TODO: Finding Elements
        findElements()
        
        //TODO: Selecting Elements
        selectElements()
        
        //TODO: Excluding Elements
        excludeElements()
        
        //TODO: Transforming an Array
        transformArray()
        
        //TODO: Iterating Over an Array’s Elements
        iterateOverArrayElements()
        
        //TODO: Reordering an Array’s Elements
        reorderArrayElements()
        
        //TODO: Splitting and Joining Elements
        splitAndJoinElements()
        
        //TODO: Creating and Applying Differences
        createAndApplyDifferences()
        
        //TODO: Comparing Arrays
        compareArrays()
        
        //TODO: Manipulating Indices
        manipulateIndices()
        
        //TODO: Accessing Underlying Storage
        accessUnderlyingStorage()
    }
    
    private func accessUnderlyingStorage() {
        var numbers1 = [1, 2, 3, 4, 5]
        let r1 = numbers1.withUnsafeBufferPointer { p in
            logger.log(p.startIndex)
            logger.log(p.endIndex)
            var ret: Int = 0
            for x in stride(from: p.startIndex, to: p.endIndex, by: 2) {
               ret += p[x]
            }
            return ret
        }
        logger.log(r1)
        numbers1.withUnsafeMutableBufferPointer { p in
            for x in stride(from: p.startIndex, to: p.endIndex - 1, by: 2) {
                p.swapAt(x, x + 1)
            }
        }
        logger.log(numbers1)
        
        var numbers: [Int32] = [1, 2, 3]
        var byteBuffer: [UInt8] = []
        numbers.withUnsafeBytes { p in
            logger.log(p is any Sequence)
            logger.log(type(of: p[0]))
            byteBuffer.append(contentsOf: p)
        }
        logger.log(byteBuffer)
        
        numbers = [0, 0]
        var byteValues: [UInt8] = [0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00]
        numbers.withUnsafeMutableBytes { destBytes in
            byteValues.withUnsafeBytes { srcBytes in
                destBytes.copyBytes(from: srcBytes)
            }
        }
        logger.log(numbers)
        
        numbers = [0, 0]
        byteValues = [0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00]
        numbers.withUnsafeMutableBytes { p1 in
            byteValues.withUnsafeBytes { p2 in
                p1.copyMemory(from: p2)
            }
        }
        logger.log(numbers)
        
        let r2: ()? = numbers1.withContiguousStorageIfAvailable { p in
            logger.log(type(of: p))
            logger.log(p[0])
        }
        logger.log(r2)
        
        numbers1.withContiguousMutableStorageIfAvailable { pointer in
            pointer[0] = 100
        }
        logger.log(numbers1)
        
        logger.log(numbers.description)
        logger.log(numbers.debugDescription)
        logger.log(numbers.hashValue)
    }
    
    private func manipulateIndices() {
        let numbers1 = [1, 2, 3, 4, 5]
        logger.log(type(of: numbers1.startIndex))
        logger.log(numbers1.startIndex)
        logger.log(numbers1.endIndex)
        logger.log(numbers1.index(after: numbers1.startIndex))
        logger.log(numbers1.index(numbers1.startIndex, offsetBy: 100))
        logger.log(numbers1.index(numbers1.startIndex + 2, offsetBy: -2, limitedBy: numbers1.endIndex))
        logger.log(numbers1.index(3, offsetBy: -2, limitedBy: 1))
        logger.log(numbers1.distance(from: 0, to: 2))
        logger.log(numbers1.distance(from: -2, to: 2))
        logger.log(numbers1.distance(from: -200, to: 200))
        
    }
    
    private func compareArrays() {
        var numbers1 = [1, 2, 3, 4, 5]
        var numbers2 = [1, 2, 3, 4, 5]
        logger.log(numbers1 == numbers2)
        
        var coffees1: [Coffeee] = []
        coffees1.append(.init(name: "Americano", from: "Brazil"))
        var coffees2: [Coffeee] = []
        coffees2.append(.init(name: "Americano", from: "Korea"))
        logger.log(coffees1 == coffees2)
        logger.log(coffees1 != coffees2)
         
        coffees1.append(.init(name: "Capucinno", from: "US"))
        
        let coffees3: Set<Coffeee> =  Set([.init(name: "Americano", from: "Brazil"), .init(name: "Capucinno", from: "US")])
        let coffees4: Set<Coffeee> =  Set([.init(name: "Capucinno", from: "Brazil"), .init(name: "Americano", from: "US")])
         
        //TODO: elementsEqual은 순서도 동일해야 한다. Set일 경우는 순서가 바뀌기 때문에
        //TODO: 그때 그때 값이 달라진다.
        logger.log(coffees1.elementsEqual(coffees3))
        logger.log(coffees1.elementsEqual(coffees4))
        
        coffees1 = []
        coffees1.append(.init(name: "Americano", from: "Brazil"))
        coffees2 = []
        coffees2.append(.init(name: "Americano", from: "Korea"))
        logger.log(coffees1 == coffees2)
        let r1 = coffees1.elementsEqual(coffees2) { c1, c2 in
            c1.name == c2.name
        }
        logger.log(r1)
        
        coffees1.append(.init(name: "Capucinno", from: "US"))
        let r2 = coffees1.starts(with: [Coffeee.init(name: "Americano", from: "Brazil")])
        logger.log(r2)
        
        let pencils1: [Pencil] = [.init(name: "donga", from: "korean"),
                                  .init(name: "staedtler", from: "germany")]
        let pencils2: [Pencil] = [.init(name: "donga", from: "korean"),
                                  .init(name: "pentel co., ltd", from: "germany")]
        
        logger.log(pencils1.lexicographicallyPrecedes(pencils2))
    }
    
    private func createAndApplyDifferences() {
        var number1 = [1, 2, 3, 4, 5]
        var number2 = [2, 1, 3, 6, 5, 9]
        
        let r1 = number1.difference(from: number2)
        logger.log(r1)
        for x in r1 {
            logger.log(x)
        }
        
        let r2 = number2.applying(r1)
        logger.log(r2)
        
        let r3 = number1.difference(from: number2) { a, b in
            logger.log("\(a) \(b)")
            return a % 2 == b % 2
        }
        for x in r3 {
            logger.log(x)
        }
        let r4 = number2.applying(r3)
        logger.log(r4)
    }
    
    private func splitAndJoinElements() {
        var numbers = [0, 1, 2, 100, 100, 3, 4, 100, 100, 5, 6, 7, 100, 100, 8, 9]
        
        let r1 = numbers.split(separator: 100, omittingEmptySubsequences: false)
        logger.log(r1)
        let r2 = numbers.split(separator: 100, omittingEmptySubsequences: true)
        logger.log(r2)
        
        let r3 = numbers.split(maxSplits: 2, omittingEmptySubsequences: true) {
            $0 == 100
        }
        logger.log(r3)
        
        var numbers1 = [1, 2, 3]
        var numbers2 = [10, 20, 30]
        let r4 = [numbers1, numbers2].joined()
        logger.log(type(of: r4))
        logger.log(r4.count)
        logger.log(Array(r4))
        let r5 = [numbers1, numbers2].joined(separator: [100])
        logger.log(type(of: r5))
        logger.log(Array(r5))
    }
    
    private func reorderArrayElements() {
        var numbers = Array(0...10)
        numbers.shuffle()
        logger.log(numbers)
        logger.log(numbers.sorted())
        logger.log(numbers)
        numbers.sort()
        logger.log(numbers)
        numbers.reverse()
        logger.log(numbers)
        numbers.shuffle()
        logger.log(numbers)
        
        //TODO: 조건을 만족하는 항목이 뒤에 배치된다.
        let r1 = numbers.partition { v in
            if v > 4 {
                return false
            }
            return true
        }
        logger.log(r1)
        logger.log(numbers)
        numbers.sort()
        numbers.swapAt(0, 1)
        logger.log(numbers)
        
    }
    
    private func iterateOverArrayElements() {
        var numbers = Array(0...10)
        numbers.forEach { v in
            logger.log(v)
        }
        numbers.forEach { v in
            logger.log(v)
            if v > 5 { return  }
            logger.log(v)
        }
        
        let names: Set = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
        logger.log(names.indices.count)
        for x in names.enumerated() {
            logger.log(x.1)
        }
        for x in names.indices {
            logger.log(names[x])
        }
        for x in zip(names.indices, names) {
            logger.log(names[x.0])
            logger.log(x.1)
        }
        
        numbers = [1, 2]
        var it = numbers.makeIterator()
        logger.log(it.next())
        logger.log(it.next())
        logger.log(it.next())
        
        it = numbers.makeIterator()
        var value = it.next()
        while value != nil {
            logger.log(value)
            value = it.next()
        }
        
        numbers = Array(0...1000)
        logger.log(numbers.underestimatedCount)
    }
    
    private func transformArray() {
        let numbers = Array(0...10)
        let numbers1 = Array(100...110)
        let r1 = [numbers, numbers1].flatMap({ $0 })
        logger.log(r1)
        let numbers2 = Array(0...100).filter { $0 % 2 == 0 }
        let r2: [[Int]] = [numbers, numbers1, numbers2]
            .compactMap { a in
                if a.allSatisfy({ $0 % 2 == 0}) {
                    return nil
                }
                return a
            }
        logger.log(r2)
        let r3 = r1.reduce(0) { partialResult, v in
            partialResult + v
        }
        logger.log(r3)
        let r4: [Int: [Int]] = r1.reduce(into: [:]) { partialResult, v in
            partialResult[v % 2, default: []].append(v)
        }
        logger.log(r4)
        
        let r5 = numbers.lazy.compactMap {
            logger.log($0)
            return $0 % 2 == 0 ? $0 : nil
        }
        logger.log("---")
        logger.log(r5)
        for x in r5 {
            logger.log("value : \(x)")
        }
        
    }
    
    private func excludeElements() {
        let numbers = Array(0...10)
        
        logger.log(numbers.dropFirst())
        logger.log(numbers.dropFirst(3))
        logger.log(numbers)
        logger.log(numbers.drop(while: { $0 < 5 }))
        let r1 = numbers.lazy.drop(while: { $0 < 5 })
        logger.log(r1)
        for x in r1 {
            logger.log(x)
        }
        logger.log(r1)
    }
    
    private func selectElements() {
        var numbers = Array(0...10)
        let r1 = numbers.prefix(3)
        logger.log(type(of: r1))
        logger.log(r1)
        
        let r2 = numbers.prefix(1003)
        logger.log(r2)
        
        let r3 = numbers.prefix(through: 3)
        logger.log(r3)
        
        let r4 = numbers.prefix(upTo: 3)
        logger.log(r4)
        
        let r5 = numbers.prefix(while: { $0 < 8})
        logger.log(r5)
        
        let r6 = numbers.suffix(3)
        logger.log(r6)
        
        let r7 = numbers.suffix(from: 3)
        logger.log(r7)
    }
    
    private func findElements() {
        var numbers = Array(0...10)
        numbers += 0...10
        logger.log(numbers)
        logger.log(numbers.contains(11))
        logger.log(numbers.contains(1))
        
        var coffees: [Coffeee] = []
        coffees.append(.init(name: "Americano", from: "Brazil"))
        coffees.append(.init(name: "Capucinno", from: "US"))
        coffees.append(.init(name: "Expresso", from: "Italy"))
        coffees.append(.init(name: "Expresso", from: "China"))
        coffees.append(.init(name: "Capucinno", from: "Thailand"))
        logger.log(coffees)
        logger.log(coffees.contains(.init(name: "Americano", from: "Brazil")))
        logger.log(coffees.contains(.init(name: "Americano", from: "Korea")))
        let r1 = coffees.contains { c in
            c.name == "Americano" && c.from == "Brazil"
        }
        logger.log(r1)
        let r2 = coffees.contains { c in
            c.name == "Americano" && c.from == "Korea"
        }
        logger.log(r2)
        
        let r3 = numbers.filter({ $0 % 2 == 0 }).allSatisfy { [0, 2, 4, 6, 8, 10].contains($0) }
        logger.log(numbers.filter({ $0 % 2 == 0 }))
        logger.log(r3)
        
        let r4 = coffees.first { $0 == "Expresso" }
        logger.log(r4)
        let r5 = coffees.first { $0 == "Express" }
        logger.log(r5)
        if let r6 = coffees.firstIndex(of: .init(name: "Capucinno", from: "")) {
            logger.log(coffees[r6])
        }
        
        let r7 = coffees.firstIndex(where: { $0 == "Capucinno"})
        logger.log(coffees[r7!])
        
        let r8 = coffees.last(where: { $0 == "Capucinno" })
        logger.log(r8)
        
        logger.log(numbers.min())
        let r9 = numbers.min(by: { a, b in
            logger.log("\(a) \(b)")
            if a % 2 == 1 {
                return false
            }
            if b % 2 == 1 {
                return true
            }
            return a < b
        })
        logger.log(r9)
        logger.log(numbers.max())
        let r10 = numbers.max(by: { a, b in
            logger.log("\(a) \(b)")
            if a % 2 == 1 {
                return false
            }
            if b % 2 == 1 {
                return true
            }
            return a < b
        })
        logger.log(r10)
    }
    
    private func removeElements() {
        var numbers = Array(0...10)
        logger.log(numbers)
        numbers.remove(at: 0)
        logger.log(numbers)
        //TODO: 범위를 넘어가는 것을 지우려고 하면 죽는다. exception처리가 없음.
//        numbers.remove(at: 100)
        logger.log(numbers.removeFirst())
        logger.log(numbers)
        logger.log(numbers.removeFirst(3))
        logger.log(numbers)
        logger.log(numbers.removeLast())
        logger.log(numbers)
        logger.log(numbers.removeLast(3))
        logger.log(numbers)
        
        numbers = Array(0...10)
        logger.log(numbers.removeSubrange(0..<2))
        logger.log(numbers)
        numbers.removeSubrange(0...2)
        logger.log(numbers)
        numbers.removeSubrange(2...)
        logger.log(numbers)
        numbers.removeSubrange(..<1)
        logger.log(numbers)
        
        numbers = Array(0...10)
        logger.log(numbers.capacity)
        numbers.removeAll { $0 % 2 == 0 }
        logger.log(numbers.capacity)
        logger.log(numbers)
        
        numbers.removeAll(keepingCapacity: true)
        logger.log(numbers.capacity)
        numbers.removeAll(keepingCapacity: false)
        logger.log(numbers.capacity)
        
        numbers = Array(0...10)
        logger.log(numbers.popLast())
        for _ in 0...10 {
            logger.log(numbers.popLast())
            logger.log(numbers)
        }
    }
    
    private func combineArrays() {
        var numbers = [0, 1, 2]
        let r1 = (0...10) + numbers
        logger.log(r1)
        let r2 = numbers + (0...10)
        logger.log(r2)
        logger.log(numbers + numbers)
        
        let lowerNumbers = [1, 2, 3, 4]
        let higherNumbers: ContiguousArray = [5, 6, 7, 8, 9, 10]
        let allNumbers = lowerNumbers + higherNumbers
        logger.log(type(of: higherNumbers))
        logger.log(type(of: allNumbers))
        logger.log(allNumbers)
        logger.log(type(of: higherNumbers + lowerNumbers))
        logger.log(higherNumbers + lowerNumbers)
        
        logger.log(type(of: numbers))
        logger.log(numbers is any RangeReplaceableCollection)
        if let a = numbers as? any RangeReplaceableCollection {
            logger.log("RangeReplaceableCollection")
        }
        numbers += [1, 2]
        logger.log(numbers)
        numbers += (100..<102)
        logger.log(numbers)
    }
    
    private func addElements() {
        var numbers = [0, 1, 2]
        numbers.append(3)
        logger.log(numbers)
        
        numbers.insert(-1, at: 0)
        logger.log(numbers)
        numbers.insert(contentsOf: [-3, -2], at: 0)
        logger.log(numbers)
        numbers[0...2] = []
        logger.log(numbers)
        numbers.replaceSubrange(0...1, with: [100, 200, 300])
        logger.log(numbers)
        let r = Range<Int>.init(uncheckedBounds: (10, 100))
        logger.log(r)
        logger.log(r.lowerBound)
        logger.log(r.upperBound)
        let r1 = ClosedRange<Int>.init(uncheckedBounds: (10, 100))
        logger.log(r1)
        logger.log(r1.lowerBound)
        logger.log(r1.upperBound)
        let r2 = Range.init(uncheckedBounds: (0, 1))
        logger.log(r2)
        logger.log(r2.lowerBound)
        logger.log(r2.upperBound)
        
        logger.log(numbers.count)
        logger.log(numbers.capacity)
        numbers.reserveCapacity(128)
        logger.log(numbers.capacity)
    }
    
    // Creating an Array
    private func createArray() {
        var numbers = Array(10...20)
        logger.log(numbers)
        numbers = Array(repeating: 11, count: 10)
        logger.log(numbers)
        
        numbers = Array.init(unsafeUninitializedCapacity: 256, initializingWith: { buffer, initializedCount in
            logger.log(type(of: buffer))
            for x in 0..<buffer.count {
                buffer[x] = 5 + x
            }
            initializedCount = buffer.count
        })
        logger.log(numbers.count)
        logger.log(numbers.capacity)
        logger.log(numbers.first)
        logger.log(numbers.last)
        logger.log(numbers[250...])
        logger.log(numbers[...10])
        logger.log(numbers[..<10])
        logger.log(numbers[8..<10])
        logger.log(numbers.randomElement())
        logger.log(numbers.randomElement())
        var generator = MyRandomNumberGenerator()
        logger.log(numbers.randomElement(using: &generator))
        var generator1 = MyPseudoRandomNumberGenerator(value: UInt64.random(in: 1...100) )
        logger.log(numbers.randomElement(using: &generator1))
        
    }
}

struct ArrayTest_Previews: PreviewProvider {
    static var previews: some View {
        ArrayTest()
    }
}

fileprivate struct Coffeee: Hashable {
    let name: String
    let from: String
    
//    static func == (lhs: Self, rhs: Self) -> Bool {
//        lhs.name == rhs.name
//    }
    
    static func == (lhs: Self, rhs: String) -> Bool {
        lhs.name == rhs
    }
}

extension Coffeee: CustomStringConvertible {
    var description: String {
        "\(name) - \(from)"
    }
}

//TODO: struct는 stored property가 모두 Hashable이면 Equatable, Hashable을 구현하지 않아도 되지만,
//TODO: class는 반드시 구현해주어야 한다.
fileprivate class Pencil: Hashable {
    static func == (lhs: Pencil, rhs: Pencil) -> Bool {
        lhs.name == rhs.name && lhs.from == rhs.from
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(from)
    }
    
    let name: String
    let from: String
    
    init(name n: String, from f: String) {
        name = n
        from = f
    }
    
}

extension Pencil: Comparable {
    static func < (lhs: Pencil, rhs: Pencil) -> Bool {
        lhs.name < rhs.name
    }
}
