//
//  UnsafeTest.swift
//  SwiftUI01
//
//  Created by we on 2023/06/01.
//

import SwiftUI

struct UnsafeTest: View {
    @State var values: [Int32] = [1, 2, 3]
    var body: some View {
        VStack {
            Text("\(values[0])")
        }
        .onAppear {
            // convert values to UnsafePointer
            var pointer = UnsafeMutablePointer<Int32>(&values)
            pointer[0] = 2
            print(values[0])
            // print hex value
            print(String(format: "%p", pointer))
        }
    }
    
    func changeValues(values: inout [Int]) {
        values[0] = 2
    }
    
    func withReboundSample() {
        var values: [Int8] = [1, 1, 1, 1, 1, 1, 1, 1]

        func changeValues(_ values: inout [Int8]) {
            values[0] = 3
        }

        //print("\(values)")
        //changeValues(&values)
        //print("\(values)")

        let pointer = UnsafePointer<Int8>(values)
        print("\(pointer[2])")

        let mpointer = UnsafeMutablePointer<Int8>(&values)
        //mpointer[2] = 99
        print("\(values)")


        //TODO: Here
        let pp = mpointer.withMemoryRebound(to: Int64.self, capacity: 1) { p in
            return p
        }
        print("\(pp[0])")
        print(String(format: "%p", pp[0]))
        pp[0] = 2
        print("\(pp[0])")
        print("\(pp[1])") // 0 index만 있지만 메모리이기 때문에 1st도 접근 가능.
        print(String(format: "%p", pp[0]))
        print("\(values)")
    }
    
    func unsafePointerTest() {
        var values: [Int8] = [1, 1, 1, 1, 1, 1, 1, -1]
        
        print("\(values)")
        //changeValues(&values)
        //print("\(values)")
        
        let pointer = UnsafePointer<Int8>(values)
        print("[2] \(pointer[2])")
        
        let pp = pointer.withMemoryRebound(to: Int64.self, capacity: 1) { p in
            return p
        }
        print(String(format: "[0] %p", pp[0]))
        print("[0] \(pp[0])")
        print("[1] \(pp[1])")
        print("\(values)")
        
        //TODO: bindMemory
        guard let u64pt = UnsafeRawPointer(pointer)?.bindMemory(to: UInt64.self, capacity: 1) else { return }
        print("\(u64pt.pointee)")
        print(String(format: "[0] %p", u64pt[0]))
        print("\(pointer.pointee)") // bindMemory 이후에는 문서에 따르면 이 동작은 보장되지 않는다.
        
        let rawPointer = UnsafeRawPointer(u64pt)
        let u8 = rawPointer.load(as: UInt8.self)
        let i64 = rawPointer.load(as: Int64.self)
        print("\(u8)")
        print("\(i64)")
        
        //TODO: 포인터 연산
        let pt2 = pointer + 7
        print("[7] \(pt2.pointee)")
        
        func printInt(atAddress p: UnsafePointer<Int8>) {
            print(p.pointee)
        }
        
        var v: Int8 = -2
        printInt(atAddress: &v)
        printInt(atAddress: pointer)
        
        var m = UnsafeMutablePointer<Int8>(&values)
        printInt(atAddress: m)
        printInt(atAddress: &m[7])
        
        var mm = UnsafeMutablePointer<Int8>(mutating: pointer)
        printInt(atAddress: mm)
        printInt(atAddress: &mm[7])
        
        //FIXME: dangling pointer
        // https://developer.apple.com/forums/thread/674633
    }
}

struct UnsafeTest_Previews: PreviewProvider {
    static var previews: some View {
        UnsafeTest()
    }
}
