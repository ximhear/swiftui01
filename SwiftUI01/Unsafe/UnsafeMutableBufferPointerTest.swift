//
//  UnsafeMutableBufferPointerTest.swift
//  SwiftUI01
//
//  Created by we on 2023/06/05.
//

import SwiftUI

struct UnsafeMutableBufferPointerTest: View {
    @State var logs: [String] = []
    var body: some View {
        List {
            ForEach(logs.reversed(), id: \.self) { log in
                Text(log)
            }
        }
        .onAppear {
            test1()
        }
    }
    func test1() {
        addLog("start test")
        struct Coffee: Codable, CustomStringConvertible {
            var name: String
            var price: String
            
            var description: String {
                "\(name) : \(price)"
            }
        }
        
        var values: [Coffee] = [
            .init(name: "아메리카노", price: "1500"),
            .init(name: "Iced americano", price: "2000"),
            .init(name: "Cold Brew", price: "3000"),
            ]
        
        let rp01 = UnsafeMutableRawPointer(mutating: &values)
        
        let bp01 = UnsafeMutableBufferPointer<Coffee>.allocate(capacity: 4)
        let result = bp01.initialize(from: values)
        bp01[0].name = "sss"
        addLog("\(result.index)")
        bp01[3] = Coffee(name: "gg", price: "11")
        
        for (index, value) in bp01.enumerated() {
            addLog("[\(index)] \(value)")
        }
        
        addLog("\(rp01)")
        addLog("\(bp01)")
        
        addLog("\(values)")
        bp01.deallocate()
    }

    func test() {
        addLog("start test")
        var values: [Int32] = [1, 2, 3, 4]
        let bp1 = UnsafeMutableBufferPointer(start: &values, count: values.count)
        addLog("\(type(of: bp1))")
        for (index, value) in bp1.enumerated() {
            addLog("\(index) : \(value)")
        }
        
        values.withUnsafeMutableBytes { buffer in
            addLog("\(type(of: buffer))")
        }
        values.withUnsafeBufferPointer { buffer in
            addLog("\(type(of: buffer))")
        }
        values.withUnsafeMutableBufferPointer { buffer in
            addLog("\(type(of: buffer))")
        }
        
        // convert values to UnsafeBufferPointer using withUnsafeBytes
        values.withUnsafeMutableBufferPointer { buffer in
            addLog("\(type(of: buffer))")
            addLog("\(buffer.count)")
            for (index, value) in buffer.enumerated() {
                addLog("\(index) : \(value)")
            }
            addLog("\(buffer[0])")

            let bp2 = UnsafeMutableBufferPointer<Int32>(rebasing: buffer[1...])
            for x in bp2.enumerated() {
                addLog("\([x.0]) : \(x.1)")
            }
            let bp6 = buffer.baseAddress! + 1
            addLog("\(bp6)")
            addLog("\(bp2.baseAddress!)")
            bp2[0] = 0x7fffffff

             // alloc UnsafeBufferPointer
            let bp3 = UnsafeMutableRawBufferPointer.allocate(byteCount: 4 * MemoryLayout<Int32>.stride, alignment: MemoryLayout<Int32>.stride)
            if let b = buffer.baseAddress {
                bp3.copyMemory(from: UnsafeRawBufferPointer(start: b, count: 16))
                addLog("\(type(of: bp3))")
                for x in bp3.enumerated() {
                    addLog("\([x.0]) : \(x.1)")
                }
            }
            bp3.deallocate()
            
            let bp4 = UnsafeMutableBufferPointer<Int32>(start: buffer.baseAddress, count: 2)
            for x in bp4.enumerated() {
                addLog("\(x)")
            }
            addLog("\(bp4.index(before: 1))")
            addLog("\(bp4.index(after: 1))")
            var index: Int = 2
            _ = bp4.formIndex(&index, offsetBy: 4, limitedBy: 2)
            addLog("\(index)")


            let bp5 = buffer.withMemoryRebound(to: Int64.self) { buffer in
                addLog("\(type(of: buffer))")
                for x in buffer.enumerated() {
                    addLog("\(String(format: "%p", x.1))")
                }
                return buffer
            }
            for x in bp5.enumerated() {
                addLog("\(String(format: "%p", x.1))")
            }
            
            let bp7 = UnsafeMutableBufferPointer<Int32>.allocate(capacity: 4)
            _ = bp7.moveUpdate(fromContentsOf: buffer)
            for x in bp7.enumerated() {
                addLog("\(String(format: "%p", x.1))")
            }
            bp7.deallocate()
            
        }
        addLog("\(values)")

    }

    func clearLogs() {
        logs.removeAll()
    }

    func addLog(_ log: String, lineNumber: Int = #line) {
        print("\(lineNumber) : \(log)")
        logs.append("\(lineNumber) : \(log)")
    }
}

struct UnsafeMutableBufferPointerTest_Previews: PreviewProvider {
    static var previews: some View {
        UnsafeMutableBufferPointerTest()
    }
}
