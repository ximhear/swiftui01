//
//  UnsafeRawPointerTest.swift
//  SwiftUI01
//
//  Created by we on 2023/06/07.
//

import SwiftUI

struct UnsafeRawPointerTest: View {
    @State var logs: [String] = []
    var body: some View {
        List {
            ForEach(logs.reversed(), id: \.self) { log in
                Text(log)
            }
        }
        .onAppear {
            test()
        }
    }
    
    func test() {
        addLog("start test")
    }
    
    func clearLogs() {
        logs.removeAll()
    }

    func addLog(_ log: String, lineNumber: Int = #line) {
        logs.append("\(lineNumber) : \(log)")
    }
}

struct UnsafeRawPointerTest_Previews: PreviewProvider {
    static var previews: some View {
        UnsafeRawPointerTest()
    }
}
