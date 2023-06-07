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
        let bytesPointer = UnsafeMutableRawPointer.allocate(byteCount: 4, alignment: 4)
        bytesPointer.initializeMemory(as: UInt32.self, repeating: 0, count: 1)
        bytesPointer.storeBytes(of: 0x0403_0201, toByteOffset: 2, as: UInt32.self)

        addLog("\(bytesPointer)")
        addLog("\(bytesPointer + 1)")

        // Load a value from the memory referenced by 'bytesPointer'
        let x1 = bytesPointer.load(as: UInt8.self)       // 255
        addLog("\(String(format: "%p", x1))")
        let x2 = bytesPointer.load(as: UInt32.self)       // 255
        addLog("\(String(format: "%p", x2))")
        
        for x in 0..<4 {
            let x1 = (bytesPointer + x).load(as: UInt8.self)       // 255
            addLog("\(String(format: "%p", x1))")
        }


        // Load a value from the last two allocated bytes
        let offsetPointer = bytesPointer + 2
        let y = offsetPointer.load(as: UInt16.self)     // 65535
        addLog("\(String(format: "%p", y))")
    }
    
    func clearLogs() {
        logs.removeAll()
    }

    func addLog(_ log: String, lineNumber: Int = #line) {
        print("\(lineNumber) : \(log)")
        logs.append("\(lineNumber) : \(log)")
    }
}

struct UnsafeRawPointerTest_Previews: PreviewProvider {
    static var previews: some View {
        UnsafeRawPointerTest()
    }
}
