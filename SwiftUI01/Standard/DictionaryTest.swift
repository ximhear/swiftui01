//
//  DictionaryTest.swift
//  SwiftUI01
//
//  Created by we on 2023/06/28.
//

import SwiftUI

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
    }
}

struct DictionaryTest_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryTest()
    }
}
