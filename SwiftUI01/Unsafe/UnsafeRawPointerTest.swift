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
            test1()
        }
    }
    
    //TODO: UnsafeRawMutablePointer
    func test1() {
        addLog("start test")
        
        var bytes: [UInt8] = [39, 77, 111, 111, 102, 33, 39, 0]
        let uint8Pointer = UnsafeMutablePointer<UInt8>.allocate(capacity: 8)
        uint8Pointer.initialize(from: &bytes, count: 8)
        
        let uint64Pointer = UnsafeMutableRawPointer(uint8Pointer)
                                  .bindMemory(to: UInt64.self, capacity: 1)
        
        var fullInteger = uint64Pointer.pointee          // OK
        addLog("\(fullInteger)")
        var firstByte = uint8Pointer.pointee             // undefined
        addLog("\(firstByte)")
        
        let rawPointer = UnsafeMutableRawPointer(uint64Pointer)
        fullInteger = rawPointer.load(as: UInt64.self)   // OK
        addLog("\(fullInteger)")
        firstByte = rawPointer.load(as: UInt8.self)      // OK
        addLog("\(firstByte)")
        
        uint64Pointer.deallocate()
    }
    
    //TODO: UnsafeRawPointer
//    func test() {
//        addLog("start test")
//        let bytesPointer = UnsafeMutableRawPointer.allocate(byteCount: 4, alignment: 4)
//        bytesPointer.initializeMemory(as: UInt32.self, repeating: 0, count: 1)
//        //TODO: 메모리를 4바이트 할당하였는데, 2번째 바이트부터 4바이트를 복사하여 할당 범위를 넘었으나 넘긴 영역에 중요한 데이터가 없다면 문제가 발생하지 않는다.
//        //TODO: 넘기지 얺도록 해야한다.
//        bytesPointer.storeBytes(of: 0x0403_0201, toByteOffset: 2, as: UInt32.self)
//
//        addLog("\(bytesPointer)")
//        addLog("\(bytesPointer + 1)")
//
//        // Load a value from the memory referenced by 'bytesPointer'
//        let x1 = bytesPointer.load(as: UInt8.self)       // 255
//        addLog("\(String(format: "%p", x1))")
//        let x2 = bytesPointer.load(as: UInt32.self)       // 255
//        addLog("\(String(format: "%p", x2))")
//        
//        for x in 0..<4 {
//            let x1 = (bytesPointer + x).load(as: UInt8.self)
//            addLog("\(String(format: "%p", x1))")
//        }
//
//
//        // Load a value from the last two allocated bytes
//        let offsetPointer = bytesPointer + 2
//        let y = offsetPointer.load(as: UInt16.self)     // 65535
//        addLog("\(String(format: "%p", y))")
//        
//        bytesPointer.deallocate()
//    }
    
    func clearLogs() {
        logs.removeAll()
    }

    func addLog(_ log: String, lineNumber: Int = #line) {
        print("\(lineNumber) : \(log)")
        logs.append("\(lineNumber) : \(log)")
        if #available(iOS 17, *) {
        }
    }
}

struct UnsafeRawPointerTest_Previews: PreviewProvider {
    static var previews: some View {
        UnsafeRawPointerTest()
    }
}
