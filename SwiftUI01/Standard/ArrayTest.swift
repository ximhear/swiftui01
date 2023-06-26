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
        createArray()
    }
    
    // Creating an Array
    private func createArray() {
        let numbers = Array(10...20)
        logger.log(numbers)
    }
}

struct ArrayTest_Previews: PreviewProvider {
    static var previews: some View {
        ArrayTest()
    }
}
