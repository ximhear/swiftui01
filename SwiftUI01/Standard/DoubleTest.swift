//
//  DoubleTest.swift
//  SwiftUI01
//
//  Created by we on 2023/06/14.
//

import SwiftUI

struct DoubleTest: View {
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
        log("start test")
        
        // Int to Double
        var u8 = 32
        var dd = Double(u8)
        var ff: Float = 32
        var f16: Float16 = 32
        var f32: Float32 = 32
        var f64: Float64 = 32
        var f80: Float80 = 32
        log(dd)
        log(Double(f80))
        
        //TODO: 3.2 * 2^-1
        //TODO: Double.radix == 2
        //TODO: 3.2 * Double.radix ^ -1
        log(Double(sign: .plus, exponent: -1, significand: 3.2))
        
        if let v = Double("32.9") {
            log(v)
            log(v.sign)
            log(v.exponent)
            log(v.significand)
        }
        
        log(Double.radix)
        
        log(Double(signOf: -21.5, magnitudeOf: 305.15))
        
        let n = NSNumber(value: 3.2382324802384089731)
        log(Double(truncating: n))
        
        if let v = Double(exactly: 3.2382324802384089731) {
            log(v)
            log(v.sign)
            log(v.exponent)
            log(v.significand)
        }
        if let v = Double(exactly: 99999999990000000927493749237492811188923749237492739427934723947293479293480238402839048203849203402840382048284238402808424824428432478754802484927349882042038402384283408230482038084023840823048230840238408329482002740572075230472039480237502357203752048203752057432048027400752483904820480284082084274027.4128402384028345) {
            log(v)
            log(v.sign)
            log(v.exponent)
            log(v.significand)
        }
        else {
            log("not exactly")
        }
        log(Double.random(in: 5...6))
        
        dd = 4
        log(dd.addingProduct(2, 9))
        dd.addProduct(2, 9)
        log(dd)
        
        dd = 2
        log(dd.squareRoot())
        dd.formSquareRoot()
        log(dd)
        
        dd = 8.625
        var divider = 0.75
        log(dd.remainder(dividingBy: divider))
        dd.formRemainder(dividingBy: divider)
        log(dd)
        
        dd = 8.625
        log(dd.truncatingRemainder(dividingBy: divider))
        
        dd = -8.625
        log(dd.remainder(dividingBy: divider))
        log(dd.truncatingRemainder(dividingBy: divider))
        
        dd = 8.625
        divider = -0.75
        log(dd.remainder(dividingBy: divider))
        log(dd.truncatingRemainder(dividingBy: divider))
        
        dd = -8.625
        divider = -0.75
        log(dd.remainder(dividingBy: divider))
        log(dd.truncatingRemainder(dividingBy: divider))
        
        dd = -8.625
        dd.negate()
        log(dd)
        
        dd = 3.5
        log(dd.rounded())
        log(dd.rounded(.toNearestOrAwayFromZero))
        // 가운데에 있다면 짝수가 되는 방향으로
        dd = 3.25
        log(dd.rounded(.toNearestOrEven))
        dd = 3.5
        log(dd.rounded(.toNearestOrEven))
        dd = 2.5
        log(dd.rounded(.toNearestOrEven))
        // up
        dd = 2.2
        log(dd.rounded(.up))
        dd = -2.2
        log(dd.rounded(.up))
        // towardZero
        dd = 2.2
        log(dd.rounded(.towardZero))
        dd = -2.2
        log(dd.rounded(.towardZero))
        // awayFromZero
        dd = 2.2
        log(dd.rounded(.awayFromZero))
        dd = -2.2
        log(dd.rounded(.awayFromZero))
        
        dd = 2.2
        log(dd.magnitude)
        dd = -2.2
        log(dd.magnitude)
        log(dd.magnitudeSquared)
        
        dd = 15.0
        log(dd.isEqual(to: 15.0)) // true
        log(dd.isEqual(to: .nan)) // false
        log(Double.nan.isEqual(to: .nan)) // false
        log(dd.isLess(than: 30.0))
        log(dd.isLess(than: .nan))
        log(dd.isLess(than: .infinity))
        log(dd.isTotallyOrdered(belowOrEqualTo: 15.1))
        log(dd.isTotallyOrdered(belowOrEqualTo: 15.0))
        
        dd = 2.2
        log(dd.significand)
        log(dd.magnitude)
        log(dd.isEqual(to: 2.2))
        log((dd * dd).isEqual(to: 4.84))
        log(dd * dd)
        log(pow(dd, 2))
        dd = 1.5
        log(Double.minimum(dd, 4.84))
        log(Double.maximum(dd, 4.84))
        log(Double.maximumMagnitude(dd, -4.84))
        log(Double.minimumMagnitude(-dd, 4.84))
        
        //TOOD: ulp는 값과 다음 유효값이 nextUp or nextDown과의 차이.
        dd = 2.2 * 2.2
        log(dd)
        log(dd.nextUp)
        log(dd.nextDown)
        log(dd.nextUp.distance(to: dd))
        log(dd.nextDown.distance(to: dd))
        log(dd.magnitude)
        log(dd.ulp)
        log(dd.exponent)
        log(dd.significand)
        
        log(Double.greatestFiniteMagnitude)
        log(Double.greatestFiniteMagnitude.ulp)
        log(Double.greatestFiniteMagnitude.nextUp)
        log(Double.greatestFiniteMagnitude.nextDown)
        log(Double.greatestFiniteMagnitude.nextDown.distance(to: .greatestFiniteMagnitude).magnitude)
        let dd1 = Double.greatestFiniteMagnitude.ulp
        let dd2 = Double.greatestFiniteMagnitude.nextDown.distance(to: .greatestFiniteMagnitude).magnitude
        log(dd1.isEqual(to: dd2))
        log(dd1 == dd2)
        
        dd = 2.2 * 2.2
        log(dd)
        log(dd.sign)
        log(dd.exponent)
        log(dd.significand)
        dd = dd.binade
        log(dd)
        log(dd.sign)
        log(dd.exponent)
        log(dd.significand)
        
        log(Double.pi)
        log(Double.infinity)
        log(Double.greatestFiniteMagnitude)
        log(Double.nan)
        log(Double.signalingNaN)
        let xx = 1.5 + Double.signalingNaN
        log(xx)
        let yy = 1.5 + Double.nan
        log(yy)
        
        log(Double.ulpOfOne)
        log(Double.leastNonzeroMagnitude)
        log(Double(0).ulp)
        log(Double.leastNormalMagnitude)
        log(Double.zero)
        dd = 1.25
        log(dd.bitPattern)
        log(String(dd.bitPattern, radix: 16))
        log(String(dd.significand.bitPattern, radix: 16))
        log(dd.exponent)
        log(String(dd.exponentBitPattern, radix: 16))
        log(Double.significandBitCount)
        log(Double.exponentBitCount)
        log(Double.radix)
        let snan = Double(nan: 1, signaling: true)
        let nan = Double(nan: 1, signaling: false)
        log(snan)
        log(nan)
        log(snan.isNaN)
        log(snan.isSignalingNaN)
        log(nan.isSignalingNaN)
        log(snan == snan)
        
        dd = 0
        log(dd.isZero)
        log(dd.isFinite)
        log(Double.infinity.isInfinite)
        
        dd = 2.2
        log(dd.isNormal)
    }
    
    func log(_ message: @autoclosure () -> Any? = "", lineNumber: Int = #line) {
        logger.addLog(message(), lineNumber: lineNumber)
    }
}

struct DoubleTest_Previews: PreviewProvider {
    static var previews: some View {
        DoubleTest()
    }
}
