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
        
    }
}

struct DoubleTest_Previews: PreviewProvider {
    static var previews: some View {
        DoubleTest()
    }
}
