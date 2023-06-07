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
        addLog("Coffee size: \(MemoryLayout<Coffee>.size)")
        addLog("Coffee stride: \(MemoryLayout<Coffee>.stride)")
        addLog("String stride: \(MemoryLayout<String>.stride)")
        addLog("Int8 stride: \(MemoryLayout<Int8>.stride)")
        
        var values: [Coffee] = [
            .init(name: "II아메리카노", price: "1500"),
            .init(name: "Iced americano", price: "2000"),
            .init(name: "Cold Brew", price: "3000"),
            ]
        
        let rp01 = UnsafeMutableRawPointer(mutating: &values)
        
        let bp01 = UnsafeMutableBufferPointer<Coffee>.allocate(capacity: 4)
        let result = bp01.initialize(from: values)
        addLog("\(result.index)")
        bp01[3] = Coffee(name: "GggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggG", price: "11")
        
        let bp02 = UnsafeMutableBufferPointer(rebasing: bp01[1...])
        
        for (index, value) in bp01.enumerated() {
            addLog("[\(index)] \(value)")
        }
        
        let bp03 = bp01.baseAddress! + 3
        
        addLog("\(rp01)")
        addLog("\(bp01)")
        addLog("\(bp02)")
        addLog("\(bp03)")
        
        UnsafeRawPointer(&(bp03.pointee.name)).withMemoryRebound(to: String.self, capacity: 1) { pointer in
            addLog("\(type(of: pointer))")
            addLog("\(pointer)")
            
        }
        let namePtr = UnsafePointer<String>.init(&(bp03.pointee.name))
        addLog("\(namePtr)")
        
        //TODO: bp01 -> raw pointer
        let rp02 = UnsafeRawPointer(bp01.baseAddress!)
        addLog("\(rp02)")
        //TODO: bp01 -> mutable raw pointer
        let rp03 = UnsafeMutableRawPointer(bp01.baseAddress!)
        addLog("\(rp03)")
        let mp01 = rp03.withMemoryRebound(to: Coffee.self, capacity: 4) { pointer in
            return pointer
        }
        addLog("\(type(of: mp01))")
        addLog("\(mp01)")
        let mp02 = rp03.bindMemory(to: Coffee.self, capacity: 4)
        addLog("\(type(of: mp02))")
        addLog("\(mp02)")

        //TODO: convert bp01[0].name String to UnsafeRawPointer
        let rp04 = UnsafeRawPointer(&(bp01[0].name))
        addLog("\(type(of: rp04))")
        addLog("\(rp04)")
        
        addLog("\(bp01[1].name)")
        let rp05 = UnsafeMutableRawPointer(&(bp01[1].name))
        rp05.storeBytes(of: 65, as: UInt8.self)
        addLog("\(type(of: rp05))")
        addLog("\(rp05)")
        addLog("\(bp01[1].name)")
        
        //TODO: convert bp01[1].name String to UnsafeMutablePointer
        withUnsafeMutablePointer(to: &(bp01[1].name)) { pointer in
            pointer.pointee = "HelloHelloHello"
            //TODO: UnsafeMutablePoint to UnsafeMutableRawPointer
            let rp = UnsafeMutableRawPointer(pointer)
            (rp + 4).storeBytes(of: 0x4344, toByteOffset: 0, as: UInt16.self)
        }
        //TODO: convert bp01[1].name String to UnsafeMutableRawBufferPointer
        withUnsafeMutableBytes(of: &(bp01[1].name)) { pointer in
            addLog("\(type(of: pointer))")
            pointer[0] = 66
            pointer.storeBytes(of: 0x4142, toByteOffset: 0, as: UInt16.self)
            if let rp = pointer.baseAddress {
                addLog("\(type(of: rp))")
                (rp + 2).storeBytes(of: 0x4142, toByteOffset: 0, as: UInt16.self)
            }
        }
        addLog("\(bp01[1].name)")
        
        var iValue: Int32 = 0x01020304
        addLog("\(iValue)")

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
