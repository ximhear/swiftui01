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
    //TODO: UnsafeMutableRawBufferPointer
    func test() {
        addLog("start test")
        var buffer: [UInt32] = [1, 2, 3, 4]
        buffer.withUnsafeMutableBytes { rbp in
            addLog("\(type(of: rbp))")
            addLog("\(rbp)")
            addLog("\(rbp.count)")
            addLog("\(rbp[0])")
            addLog("\(rbp[4])")
            addLog("\(rbp[8])")
            addLog("\(rbp[12])")
            
            let destBytes = rbp[0..<4]
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
            let value1: Int64 = rbp.load(fromByteOffset: 8, as: Int64.self)
            addLog("\(String(format: "%p", value1))")
            let value2: Int64 = rbp.loadUnaligned(fromByteOffset: 1, as: Int64.self)
            addLog("\(String(format: "%p", value2))")
            rbp.storeBytes(of: 0xFFFF, as: UInt16.self)
            let value3: Int16 = rbp.load(fromByteOffset: 0, as: Int16.self)
            addLog("\(String(format: "%d", value3))")
            addLog("\(rbp[0])")
            addLog("\(rbp[1])")
            addLog("\(rbp[2])")
            
            addLog("-----")
            let bytes: [UInt8] = [1,2,3,4]
            rbp.copyBytes(from: bytes)
            addLog("\(rbp[0])")
            addLog("\(rbp[1])")
            addLog("\(rbp[2])")
            
            addLog("-----")
            var bytes1: [UInt8] = [2,3,4,5]
            let uint8Pointer = UnsafePointer(bytes1)
//            let r = UnsafeRawBufferPointer(start: bytes1, count: 4)
            let r = UnsafeRawBufferPointer(start: uint8Pointer, count: 4)
            rbp.copyMemory(from: r)
            addLog("\(rbp[0])")
            addLog("\(rbp[1])")
            addLog("\(rbp[2])")
            
            var bytes2: [UInt8] = [11, 12, 13, 14]
            bytes2.withUnsafeBytes { bytePointer in
                addLog("-----")
                addLog("\(bytePointer.count)")
                rbp.copyMemory(from: bytePointer)
                addLog("\(rbp[0])")
                addLog("\(rbp[1])")
                addLog("\(rbp[2])")
                addLog("\(rbp[3])")
            }
        }
    }
    //TODO: UnsafeRawBufferPointer
    func test1() {
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
