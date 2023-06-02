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
        
        //TODO: dangling pointer warning을 없애려면 전역함수 withUnsafePointer을 이용해야 한다.
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
        
        printInt(atAddress: values)
        var mutableValues = values
        printInt(atAddress: mutableValues)
        printInt(atAddress: &mutableValues)

        //TODO: pointer(to:) 함수
        class Temp: Codable {
            let name: String
            let address: String
            init(name: String, address: String) {
                self.name = name
                self.address = address
            }
        }
        var t = Temp(name: "ggg", address: "aaa")
        var ptTemp = UnsafePointer(&t)
        var ptTemp1 = UnsafePointer(&t)
        //TODO: &이 있는 mutable 객체일 경우, UnsafePointer을 여러번 시도해도 항상 동일한 주소가 나온다. withUnsafePointer를 이용해도 동일한 주소.
        print("\(ptTemp)")
        print("\(ptTemp1)")
        if let ptName = ptTemp.pointer(to: \.name) {
            print("\(type(of: ptName))")
            print("\(ptName[0])")
            let mpt = UnsafeMutablePointer(mutating: ptName)
            mpt[0] = "cccddd 점점 길어지는구나. 스마트케어"
            print("\(mpt[0])")
            print(t)
        }
        
        print(Unmanaged.passUnretained(t).toOpaque())
        withUnsafePointer(to: t) { ptTemp in
            if let ptName = ptTemp.pointer(to: \.name) {
                print("\(type(of: ptName))")
                print("\(ptName[0])")
                let mpt = UnsafeMutablePointer(mutating: ptName)
                mpt[0] = "점점 길어지는구나. 스마트케어"
                print("\(mpt[0])")
                print(ptTemp[0])
            }
        }
        withUnsafePointer(to: t) { ptTemp in
            print("\(ptTemp)")
            let mpt = UnsafeMutablePointer(mutating: ptTemp)
            print("\(mpt)")
        }
        withUnsafePointer(to: t) { ptTemp in
            print("\(ptTemp)")
            let mpt = UnsafeMutablePointer(mutating: ptTemp)
            print("\(mpt)")
        }
        withUnsafePointer(to: &t) { ptTemp in
            print("\(ptTemp)")
        }
        withUnsafePointer(to: &t) { ptTemp in
            print("\(ptTemp)")
        }
        print(t)
        
        if let ptII = pointer.pointer(to: \.self) {
            let mpt = UnsafeMutablePointer(mutating: ptII)
            mpt[2] = 3
            print("\(mpt[2])")
        }
        print("\(values)")

        //FIXME: dangling pointer
        // https://developer.apple.com/forums/thread/674633
    }
}

struct UnsafeTest_Previews: PreviewProvider {
    static var previews: some View {
        UnsafeTest()
    }
}
