//
//  UnsafeBufferPointerTest.swift
//  SwiftUI01
//
//  Created by we on 2023/06/05.
//

import SwiftUI

struct UnsafeBufferPointerTest: View {
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
        var values: [Int32] = [1, 2, 3, 4]
        let bp1 = UnsafeBufferPointer(start: values, count: values.count)
        addLog("\(type(of: bp1))")
        for (index, value) in bp1.enumerated() {
            addLog("\(index) : \(value)")
        }
        
        values.withUnsafeMutableBytes { buffer in
            addLog("\(type(of: buffer))")
        }
        
        // convert values to UnsafeBufferPointer using withUnsafeBytes
        values.withUnsafeBytes { buffer in
            addLog("\(type(of: buffer))")
            let bufferPointer = UnsafeBufferPointer(start: buffer.baseAddress?.assumingMemoryBound(to: Int32.self), count: values.count)
            addLog("\(type(of: bufferPointer))")
            addLog("\(bufferPointer.count)")
            for (index, value) in bufferPointer.enumerated() {
                addLog("\(index) : \(value)")
            }
            addLog("\(bufferPointer[0])")
            
            let bp2 = UnsafeBufferPointer<Int32>(rebasing: bufferPointer[1...])
            for x in bp2.enumerated() {
                addLog("\([x.0]) : \(x.1)")
            }
            let bp6 = bufferPointer.baseAddress! + 1
            addLog("\(bp6)")
            addLog("\(bp2.baseAddress!)")
            
             // alloc UnsafeBufferPointer
            let bp3 = UnsafeMutableBufferPointer<Int32>.allocate(capacity: values.count)
            let r = bp3.initialize(from: values)
            addLog("\(r)")
            addLog("\(type(of: bp3))")
            addLog("\(values)")
            bp3[1] = 100
            for x in bp3.enumerated() {
                addLog("\([x.0]) : \(x.1)")
            }
            bp3.deallocate()
            
            let bp4 = UnsafeBufferPointer(start: buffer.baseAddress?.bindMemory(to: Int32.self, capacity: values.count), count: values.count)
            for x in bp4.enumerated() {
                addLog("\(x)")
            }
            addLog("\(bp4.index(before: 1))")
            addLog("\(bp4.index(after: 1))")
            var index: Int = 2
            _ = bp4.formIndex(&index, offsetBy: 4, limitedBy: 3)
            addLog("\(index)")
            
            
            let bp5 = bufferPointer.withMemoryRebound(to: Int64.self) { buffer in
                addLog("\(type(of: buffer))")
                for x in buffer.enumerated() {
                    addLog("\(String(format: "%p", x.1))")
                }
                return buffer
            }
            for x in bp5.enumerated() {
                addLog("\(String(format: "%p", x.1))")
            }
        }

    }

    func clearLogs() {
        logs.removeAll()
    }

    func addLog(_ log: String, lineNumber: Int = #line) {
        logs.append("\(lineNumber) : \(log)")
    }
    
}

struct UnsafeBufferPointerTest_Previews: PreviewProvider {
    static var previews: some View {
        UnsafeBufferPointerTest()
    }
}
