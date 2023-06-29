//
//  OptionSetTest.swift
//  SwiftUI01
//
//  Created by we on 2023/06/29.
//

import SwiftUI

struct OptionSetTest: View {
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
    
    private func test() {
        var o1: ShippingOptions = []
        logger.log(o1)
        var o2 = ShippingOptions()
        logger.log(o2)
        o1.insert(.nextDay)
        o2.insert(.secondDay)
        let o3 = o1.union(o2)
        logger.log(o3)
        logger.log(o3.contains(.secondDay))
        
        var o5 = ShippingOptions()
        o5.insert(.standard4)
        logger.log(o5)
        
//        var o4 = OrderType()
//        logger.log(o4)
//        o4.insert(.aa)
//        logger.log(o4)
    }
}

fileprivate struct ShippingOptions: OptionSet {
    let rawValue: Int8
    
    static let nextDay = ShippingOptions(rawValue: 1 << 0)
    static let secondDay = ShippingOptions(rawValue: 1 << 1)
    static let priority = ShippingOptions(rawValue: 1 << 2)
    static let standard = ShippingOptions(rawValue: 1 << 3)
    static let standard1 = ShippingOptions(rawValue: 1 << 4)
    static let standard2 = ShippingOptions(rawValue: 1 << 5)
    static let standard3 = ShippingOptions(rawValue: 1 << 6)
    static let standard4 = ShippingOptions(rawValue: 1 << 7)
    
    static let express: ShippingOptions = [.nextDay, .secondDay]
    static let all: ShippingOptions = [.express, .priority, .standard]
}

//@OptionSet<UInt32>
//struct OrderType {
//    private enum Options: Int {
//        case aa
//        case bb
//        case cc
//    }
//}

struct OptionSetTest_Previews: PreviewProvider {
    static var previews: some View {
        OptionSetTest()
    }
}
