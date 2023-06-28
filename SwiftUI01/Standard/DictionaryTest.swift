//
//  DictionaryTest.swift
//  SwiftUI01
//
//  Created by we on 2023/06/28.
//

import SwiftUI

enum Count: Int {
    case one = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case hundred = 100
    case thousand = 1000
    case million = 1_000_000
    case billion = 1_000_000_000
}
struct DictionaryTest: View {
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
    
    private func makeDictionary() -> [Count: Int] {
        var dic0: [Count: Int] = [
            .one: 1,
            .two: 2,
            .three: 3,
            .four: 4,
            .five: 5,
            .six: 6,
            .seven: 7,
            .eight: 8,
            .nine: 9,
            .ten: 10,
        ]
        return dic0
    }
    
    private func test() {
        let dic = [1: "1",
                          2: "2",
                          3: "3"]
        for x in dic {
            logger.log(x)
        }
        
        let keyValues: KeyValuePairs = [
            1: "1",
            2: "2",
            3: "3"]
        for x in keyValues {
            logger.log(x)
        }
        
        let imagePaths = [
            "star": "/glyphs/star.png",
            "portrait": "/images/content/portrait.jpg",
            "spacer": "/images/shared/spacer.gif"
        ]
        let glyphIndex = imagePaths.firstIndex(where: { $0.value.hasPrefix("/glyphs") })
        logger.log(type(of: glyphIndex))
        logger.log(glyphIndex)
        if let index = glyphIndex {
            logger.log("The '\(imagePaths[index].key)' image is a glyph.")
        } else {
            logger.log("No glyphs found!")
        }
        
        let nsDic = imagePaths as NSDictionary
        logger.log(nsDic)
        logger.log(imagePaths)
        
        //TODO: Creating a Dictionary
        createDictionary()
        
        //TODO: Accessing Keys and Values
        accessKeysAndValues()
        
        //TODO: Adding Keys and Values
        addKeysAndValues()
        
        //TODO: Removing Keys and Values
        removeKeysAndValues()
        
        //TODO: Iterating over Keys and Values
        iterateOverKeysAndValues()
        
        //TODO: Finding Elements
        findElements()
        
        //TODO: Transforming a Dictionary
        transformDictionary()
        
        //TODO: Creating a Dictionary from an Attribute Container
        createDictionaryFromAttributeContainer()
    }
    
    private func createDictionaryFromAttributeContainer() {
        
    }
    
    private func transformDictionary() {
        var dic0 = makeDictionary()
        var dic1 = dic0.mapValues { v in
            v * 10
        }
        logger.log(dic1)
        
        let r1 = dic0.reduce(0) { partialResult, e in
            partialResult + e.value
        }
        logger.log(r1)
        
        let r2 = dic0.reduce(into: Set<Int>()) { partialResult, e in
            partialResult.update(with: e.value)
        }
        logger.log(r2)
        logger.log(type(of: r2))
        
        let r3: [Int]? = dic0.compactMap { e in
            if e.key.rawValue % 2 == 0 { return nil }
            return e.value
        }
        logger.log(r3)
        logger.log(type(of: r3))
        
        let r4 = dic0.compactMapValues { v -> Int? in
            v % 2 == 0 ? v : nil
        }
        logger.log(r4)
        logger.log(type(of: r4))
        
        dic1 = makeDictionary()
        var dic2: [Count: Int] = [.hundred: 100, .million: 1000000, .billion: 1_000_000_000]
        let r5 = [dic1, dic2].flatMap { v in
            v
        }
        logger.log(r5)
        let r6 = dic0.flatMap { e in
            e.value
        }
        logger.log(r6)
        
        let r7 = dic0.sorted { e1, e2 in
            e1.value > e2.value
        }
        logger.log(r7)
        logger.log(dic0.map({ $0.value }))
        logger.log(dic0.shuffled().map({ $0.value }))
        logger.log(dic0.shuffled().map({ $0.value }))
        
        logger.log(dic0.hashValue)
        
    }
    
    private func findElements() {
        var dic0 = makeDictionary()
        let r1 = dic0.contains { e in
            e.key == .hundred
        }
        logger.log(r1)
        dic0[.hundred] = 100
        let r2 = dic0.contains { e in
            e.key == .hundred
        }
        logger.log(r2)
        
        if let r3 = dic0.firstIndex(where: {$0.key == .eight}) {
            logger.log(dic0[r3])
        }
        
        let r4 = dic0.min { e1, e2 in
            e1.value < e2.value
        }
        logger.log(r4)
        let r5 = dic0.max { e1, e2 in
            e1.value < e2.value
        }
        logger.log(r5)
    }
    
    private func iterateOverKeysAndValues() {
        var dic0 = makeDictionary()
        dic0.forEach { e in
            logger.log(e)
        }
        for x in dic0.enumerated() {
            logger.log("\(x.0) - \(x.1)")
        }
        let r1 = dic0.map { e in
            logger.log(e.0)
            return e.0
        }
        let r2 = dic0.lazy.map { e in
            logger.log(e.0)
            return e.0
        }
        logger.log("start FOR loop")
        logger.log(r2.count)
        for x in r2 {}
        
        var it = dic0.makeIterator()
        while true {
            if let v = it.next() {
                logger.log(v.value)
            }
            else {
                break
            }
        }
        logger.log(dic0.count)
        logger.log(dic0.underestimatedCount)
    }
    
    private func removeKeysAndValues() {
        var dic0 = makeDictionary()
        var dic1 = dic0.filter { e in
            e.value % 2 == 0
        }
        logger.log(dic1)
        logger.log(dic1.removeValue(forKey: .hundred))
        logger.log(dic1.removeValue(forKey: .eight))
        logger.log(dic1.count)
        
        logger.log(dic0.count)
        if let index = dic0.index(forKey: .eight) {
            dic0.remove(at: index)
            logger.log(dic0.count)
        }
        dic0.removeAll()
        logger.log(dic0.capacity)
        dic0 = makeDictionary()
        dic0.removeAll(keepingCapacity: true)
        logger.log(dic0.capacity)
        
        dic0 = makeDictionary()
        logger.log(dic0 == dic1)
        dic1 = makeDictionary()
        logger.log(dic0 == dic1)
        dic1[.eight] = nil
        dic1[.eight] = 8
        logger.log(dic0 == dic1)
        logger.log(dic0.values)
        logger.log(dic1.values)
    }
    
    private func addKeysAndValues() {
        var dic0 = makeDictionary()
        
        logger.log(dic0.count)
        dic0.updateValue(100, forKey: .hundred)
        logger.log(dic0.count)
        
        dic0 = makeDictionary()
        dic0.merge([.eight: 80]) { v1, v2 in
            v2
        }
        logger.log(dic0[.eight])
        logger.log(dic0.count)
        logger.log(dic0.capacity)
        dic0.merge([(Count.eight, 8), (Count.thousand, 1000)]) { v1, v2 in
            v2
        }
        logger.log(dic0)
        dic0.reserveCapacity(100)
        logger.log(dic0.count)
        logger.log(dic0.capacity)
        dic0.merge([(Count.million, 8), (Count.billion, 1000)]) { v1, v2 in
            v2
        }
        logger.log(dic0.count)
        logger.log(dic0.capacity)
        
        dic0 = makeDictionary()
        var dic1 = dic0.merging([(Count.million, 8), (Count.billion, 1000)]) { v1, v2 in
            v2
        }
        logger.log(dic0.count)
        logger.log(dic1.count)
    }
    
    private func accessKeysAndValues() {
        var dic0: [Count: Int] = [
            .one: 1,
            .two: 2,
            .three: 3,
            .four: 4,
            .five: 5,
            .six: 6,
            .seven: 7,
            .eight: 8,
            .nine: 9,
            .ten: 10,
        ]
        logger.log(dic0[.one])
        logger.log(dic0[.hundred])
        dic0[.hundred] = 100
        logger.log(dic0[.hundred])
        logger.log(dic0.count)
        dic0[.hundred] = nil
        logger.log(dic0.count)
        
        var dic1: [Int: DicValue] = [:]
        dic1[0] = DicValue.init(value: 0)
        let v1 = dic1[0]
        dic1[0]?.value += 2
        
        logger.log(v1)
        logger.log(dic1)
        
        //TODO: Value가 class인 경우 default를 통해서 얻은 값을 수정할 경우 dictionary에 적용되지 않는다.
        dic1[1, default: .init(value: 1)].value += 2
        logger.log(dic1)
        
        var v2 = dic1[2, default: .init(value: 2)]
        v2.value += 2
        dic1[2] = v2
        logger.log(dic1)
        
        if let index = dic1.index(forKey: 2) {
            logger.log(type(of: index))
            let v = dic1[index]
            logger.log(type(of: v))
            logger.log(v.0)
            logger.log(v.1)
            logger.log(v.key)
            logger.log(v.value)
        }
        
        logger.log(dic1.keys)
        logger.log(dic1.values)
        let r1 = zip(dic1.keys, dic1.values)
        logger.log(r1)
        
        var dic2 = Dictionary(uniqueKeysWithValues: r1)
        logger.log(dic2)
    
        logger.log(dic2.first)
        logger.log(dic2.randomElement())
        logger.log(dic2.randomElement())
    }
    
    private func createDictionary() {
        var dic0: [String: String] = .init()
        var dic1: [String: String] = .init(minimumCapacity: 100)
        logger.log(dic0.capacity)
        logger.log(dic1.capacity)
        
        let dic2 = Dictionary(uniqueKeysWithValues: [("g", 1), ("h", 2)])
        logger.log(dic2)
        
        let dic3 = Dictionary([("g", 1), ("h", 2), ("g", 100), ("g", 125), ("g", 3)]) { v1, v2 in
            max(v1, v2)
        }
        logger.log(dic3)
        
        var arr = Array(0...1000)
        var dic4 = Dictionary(grouping: arr) { e in
            e / 100
        }
        logger.log(dic4)
        logger.log(dic4.keys)
        for x in dic4 {
            logger.log("key: \(x.key), count: \(x.value.count)")
        }
        logger.log(dic4.isEmpty)
        logger.log(dic4.count)
        logger.log(dic4.capacity)
    }
}

struct DictionaryTest_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryTest()
    }
}

fileprivate class DicValue: CustomStringConvertible {
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
    
    var description: String {
        "\(value)"
    }
}
