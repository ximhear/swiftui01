//
//  SimdTest.swift
//  SwiftUI01
//
//  Created by we on 2023/06/29.
//

import SwiftUI
import Combine

struct SimdTest: View {
    @ObservedObject var logger: Logger = .init()
    @State var cancellable: AnyCancellable?
    
    var body: some View {
        List {
            ForEach(logger.logs.reversed(), id: \.self) { log in
                Text(log)
            }
        }
        .onAppear {
            Task {
                await test()
            }
        }
    }
    
    private func test() async {
        let r1 = SIMD2(1, 2)
        logger.log(r1)
        let r2 = SIMD2(2, 3)
        let r3 = r1 &* r2
        logger.log(r3)
        let r4 = r1 &- r2
        logger.log(r4)
        let r5 = r1 .!= r2
        logger.log(r5)
        let r7 = SIMD2(1, 2)
        let r8 = r1 .!= r7
        logger.log(r8)
        let r9 = r1 .== r7
        logger.log(r9)
        let r10 = SIMD2(1, 3)
        let r11 = r1 .== r10
        logger.log(r11)
        let r12 = r1 .<= r10
        logger.log(r12)
        logger.log(type(of: r12))
        
        let r13 = SIMD2<Float>()
        logger.log(r13)
        
        let r14 = SIMD2<Double>(r1)
        logger.log(r14)
        
        let r15 = SIMD2<Double>(1.4, 1.5)
        let r16 = SIMD2<Int>.init(r15, rounding: .awayFromZero)
        logger.log(r16)
        let r17 = SIMD2<Int8>.init(clamping: SIMD2<Int64>.init(Int64.min, Int64.max))
        logger.log(r17)
        
        let r18 = SIMD2<Int8>.init(truncatingIfNeeded: SIMD2<Int16>.init(.init(bitPattern: 0xFF0F), 0x7FFF))
        logger.log(r18)
        
        var r19 = SIMD2.init(x: 1, y: 100)
        logger.log(r19)
        logger.log(r19.scalarCount)
        logger.log(r19[0])
        logger.log(r19[1])
        r19[0] = 10
        logger.log(r19)
        
        let r20 = SIMD2<Int>.init(0...1)
        logger.log(r20)
        var r21 = SIMD2<Int>.init([3, 9])
        logger.log(r21)
        r21.replace(with: [4, 16], where: [true, false])
        logger.log(r21)
        
        simd2([3, 4])
        iii(3)
        
        let r22 = SIMD4<Int>([1, 2, 3, 4])
        logger.log(r22)
        logger.log(r22.lowHalf)
        logger.log(r22.highHalf)
        logger.log(r22.evenHalf)
        logger.log(r22.oddHalf)
    }
    
    func simd2(_ v: SIMD2<Int>) {
        logger.log(v)
    }
    
    private func iii(_ v: IntAlternative) {
        logger.log(v)
    }
}

fileprivate struct IntAlternative: ExpressibleByArrayLiteral, ExpressibleByIntegerLiteral {
    init(integerLiteral value: Int) {
        self.value = value
    }
    
    typealias IntegerLiteralType = Int
    
    init(arrayLiteral elements: Int...) {
        value = elements.first ?? 0
    }
    
    typealias ArrayLiteralElement = Int
    
    let value: Int
    
    init(_ v: Int) {
        value = v
    }
}

struct SimdTest_Previews: PreviewProvider {
    static var previews: some View {
        SimdTest()
    }
}
