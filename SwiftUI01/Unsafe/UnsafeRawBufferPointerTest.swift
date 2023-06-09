//
//  UnsafeRawBufferPointerTest.swift
//  SwiftUI01
//
//  Created by we on 2023/06/09.
//

import SwiftUI

struct UnsafeRawBufferPointerTest: View {
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
    //TODO: UnsafeRawBufferPointer
    func test() {
        addLog("start test")
        
        var buffer: [UInt32] = [1, 2, 3, 4]
        withUnsafePointer(to: &(buffer[0])) { p in
            addLog("\(type(of: p))")
            addLog("\(p)")
            addLog("\(p[0])")
            addLog("\(p[1])")
        }
        
        buffer.withUnsafeBytes { rbp in
            addLog("\(type(of: rbp))")
            addLog("\(rbp)")
            addLog("\(rbp.count)")
            addLog("\(rbp[0])")
            addLog("\(rbp[4])")
            addLog("\(rbp[8])")
            addLog("\(rbp[12])")
            
            var destBytes = rbp[0..<4]
            addLog("\(type(of: destBytes))")
            var byteArray: [UInt8] = Array(destBytes)
            addLog("\(type(of: byteArray))")
            addLog("\(byteArray)")
            byteArray += rbp[4..<rbp.count]
            addLog("\(byteArray)")
            byteArray[0] = 100
            addLog("\(byteArray)")
            addLog("\(rbp[0])")
            
            let value: Int64 = rbp.load(as: Int64.self)
            addLog("\(String(format: "%p", value))")
        }
    }
    
    func clearLogs() {
        logs.removeAll()
    }

    func addLog(_ log: String, lineNumber: Int = #line) {
        print("\(lineNumber) : \(log)")
        logs.append("\(lineNumber) : \(log)")
    }
}

struct UnsafeRawBufferPointerTest_Previews: PreviewProvider {
    static var previews: some View {
        UnsafeRawBufferPointerTest()
    }
}
