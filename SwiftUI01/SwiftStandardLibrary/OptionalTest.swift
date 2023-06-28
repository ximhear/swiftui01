//
//  OptionalTest.swift
//  SwiftUI01
//
//  Created by gzonelee on 2023/06/29.
//

import SwiftUI
import Combine

struct OptionalTest: View {
    @ObservedObject var logger: Logger = .init()
    @State var cancellable: AnyCancellable?
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
        var r1: Int? = Optional.some(23)
        var r2: Int? = 23
        var r3: Int? = nil
        logger.log(r1 == r2)
        print(r1)
        print(r1.unsafelyUnwrapped)
        print(r1!)
        //TODO: Optional.publisher은 한번만 호출된다.
        cancellable = r3.publisher.sink(receiveCompletion: { c in
            logger.log(c)
        }, receiveValue: { v in
            logger.log(v)
        })
        logger.log(cancellable)
        logger.log(r3.publisher)
        r2 = 24
        logger.log(r2)
    }
}

struct OptionalTest_Previews: PreviewProvider {
    static var previews: some View {
        OptionalTest()
    }
}
