//
//  NumberTest.swift
//  SwiftUI01
//
//  Created by we on 2023/06/12.
//

import SwiftUI

struct NumberTest: View {
    @ObservedObject var logger: Logger = .init()
    
    var body: some View {
        List {
            ForEach(logger.logs.reversed(), id: \.self) { log in
                Text(log)
            }
        }
        .onAppear {
            test()
        }
    }
    
    func test() {
        logger.addLog("start")
        
        var i8: Int8 = .max
        logger.addLog(i8)
        //TODO: overflow
//        i8 += 1
        i8 &+= 1
        logger.addLog(i8)
        i8 &+= 1
        logger.addLog(i8)
        
        var u8: UInt8 = .max
        logger.addLog(u8)
        u8 &+= 1
        logger.addLog(u8)
        
        if let v = Int8(exactly: 1000) {
            logger.addLog(v)
        }
        else {
            logger.addLog("failed")
        }
        i8 = Int8(clamping: 300)
        logger.addLog(i8)
        i8 = Int8(clamping: -973)
        logger.addLog(i8)
        
        var a: Int16 = 1300
        logger.addLog(String(format: "%p", a))
        logger.addLog(String(format: "%p", a & 0xff))
        i8 = Int8(truncatingIfNeeded: a)
        logger.addLog(i8)
        
        a = -500
        logger.addLog(String(format: "%p", a))
        logger.addLog(String(format: "%p", a & 0xff))
        i8 = Int8(truncatingIfNeeded: a)
        logger.addLog(i8)
        
        i8 = -21
        logger.addLog(String(format: "%p", i8))
        var i16 = Int16.init(truncatingIfNeeded: i8)
        logger.addLog(i16)
        logger.addLog(String(format: "%p", i16))
        var u16 = UInt16.init(truncatingIfNeeded: i8)
        logger.addLog(u16)
        logger.addLog(String(format: "%p", u16))
        u16 = .init(bitPattern: i16)
        logger.addLog(u16)
        logger.addLog(String(format: "%p", u16))
        
        if let v = Int8.init(exactly: NSNumber(value: 1290.0)) {
            logger.addLog(v)
        }
        else {
            logger.addLog("nil")
        }
        
        //TODO: preview build가 안되어 막아놓는다.
        // Int8.init(truncatingIfNeeded:)와 동일한 결과를 보인다.
//        i8 = Int8.init(truncating: NSNumber(value: -500.0))
//        logger.addLog(i8)
        
        i8 = .init(16.5)
        logger.addLog(i8)
        i8 = .init(-16.5)
        logger.addLog(i8)
        
        if let v = Int8("32") {
            logger.addLog(v)
        }
        if let v = Int8("132") {
            logger.addLog(v)
        }
        else {
            logger.addLog()
        }
        
        var i64: Int64 = 0
        if let v = Int64.init("111") {
            logger.addLog(v)
        }
        if let v = Int64.init("111", radix: 2) {
            logger.addLog(v)
        }
        if let v = Int64.init("111", radix: 8) {
            logger.addLog(v)
        }
        if let v = Int64.init("-111", radix: 8) {
            logger.addLog(v)
        }
        if let v = Int64.init("111", radix: 16) {
            logger.addLog(v)
        }
        if let v = Int64.init("111", radix: 11) {
            logger.addLog(v)
        }
        if let v = Int64.init("2e+2") {
            logger.addLog(v)
        }
        else {
            logger.addLog()
        }
        
        i8 = .random(in: 0..<100)
        logger.addLog(i8)
        i8 = .random(in: 0...100)
        logger.addLog(i8)
        
        var generator = SystemRandomNumberGenerator()
        logger.addLog(generator.next())
        logger.addLog(generator.next(upperBound: UInt64(UInt64.max >> 56)))
        
        var exposures: [UInt64: Int64] = [:]
        for _ in 0..<10 {
            let v = generator.next(upperBound: UInt64(UInt64.max >> 60 + 1))
            if let k = exposures[v] {
                exposures[v] = k + 1
            }
            else {
                exposures[v] = 0
            }
        }
        for x in exposures.keys.sorted().reversed() {
            logger.addLog("\(x) : \(exposures[x]!)")
        }
        
        exposures = [:]
        for _ in 0..<10 {
            i8 = .random(in: 0...10, using: &generator)
            let v = UInt64(i8)
            if let k = exposures[v] {
                exposures[v] = k + 1
            }
            else {
                exposures[v] = 0
            }
        }
        for x in exposures.keys.sorted().reversed() {
            logger.addLog("\(x) : \(exposures[x]!)")
        }
        
        i8 = 0x7f
        logger.addLog(i8)
        i8 = 0x7f & 0x0f
        logger.addLog(i8)
        i8 &= 0x02
        logger.addLog(i8)
        logger.addLog(~i8)
        i8.negate()
        logger.addLog(i8)
        
        u8 = 0x7f
        logger.addLog(u8)
        u8 = 0x7f & 0x0f
        logger.addLog(u8)
        u8 &= 0x02
        logger.addLog(u8)
        logger.addLog(~u8)
        
        
        i8 = 12
        logger.addLog(i8.quotientAndRemainder(dividingBy: 3))
        logger.addLog(i8.quotientAndRemainder(dividingBy: -3))
        
        u8 = 12
        logger.addLog(u8.quotientAndRemainder(dividingBy: 3))
        
        i8 = 12
        logger.addLog(i8.isMultiple(of: 3))
        logger.addLog(i8.isMultiple(of: 7))
        i8 = -12
        logger.addLog(i8.isMultiple(of: 3))
        logger.addLog(i8.isMultiple(of: 7))
        
        i8 = 10
        logger.addLog(i8.addingReportingOverflow(127))
        i8 = .init(bitPattern: 137)
        logger.addLog(i8)
        logger.addLog(255 - 137 + 1)
        
        //TODO: preview에서 보이지않아서 주석처리
//        i8 = -128
//        logger.addLog(i8.subtractingReportingOverflow(10))
//        logger.addLog(-128 - 10 + 255 + 1)
       
        i8 = 127
        logger.addLog(i8.multipliedReportingOverflow(by: 2))
    }
}

struct NumberTest_Previews: PreviewProvider {
    static var previews: some View {
        NumberTest()
    }
}
