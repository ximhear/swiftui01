//
//  ResultTest.swift
//  SwiftUI01
//
//  Created by we on 2023/06/29.
//

import SwiftUI
import Combine

fileprivate enum TestError: Error {
    case timeout
    case decodingError
}

fileprivate enum OtherTestError: Error {
    case errorHappened
}

struct ResultTest: View {
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
        logger.log(Thread.isMainThread)
        let r1 = Result<Bool, TestError>.success(true)
        logger.log(r1)
        let r2 = Result<String, TestError>.failure(.decodingError)
        logger.log(r2)
        
        let r3 = await api1()
        logger.log(Thread.isMainThread)
        logger.log(r3)
        
        let r4 = Result<Bool, any Error>.init {
            let r = Int.random(in: 0..<100)
            if r % 2 == 0 {
                return true
            }
            throw TestError.decodingError
        }
        logger.log(r4)
        do {
            let r5 = try r4.get()
            logger.log(r5)
        }
        catch {
            logger.log(error)
        }
        
        let r6 = r1.map { v -> Result<String, TestError> in
            if v == true {
                return .success("true")
            }
            else {
                return .success("false")
            }
        }
        logger.log(r6)
        
        let r7 = r2.mapError { error in
            OtherTestError.errorHappened
        }
        logger.log(r7)
        
        let r8 = r6.flatMap { str in
            Result<Bool, TestError>.success(false)
        }
        logger.log(r8)
        
        let r9 = r7.flatMapError { error in
            Result<String, TestError>.failure(.timeout)
        }
        logger.log(r9)
        
        logger.log(r9 == r2)
        logger.log(r1 == r8)
        logger.log(r1 == Result<Bool, TestError>.success(true))
        logger.log(r9 == Result<String, TestError>.failure(.timeout))
        
        cancellable = r3.publisher.sink(receiveCompletion: { c in
            logger.log(c)
        }, receiveValue: { v in
            logger.log(v)
        })
    }
    
    private func api1() async -> Result<Bool, TestError> {
        let result = Task {
            logger.log(Thread.isMainThread)
            do {
                // 1초 == 1_000_000_000
                try await Task.sleep(nanoseconds: 1_000_000_000)
            }
            catch {
                logger.log(error)
            }
            let r = Int.random(in: 0..<100)
            if r % 2 == 0 {
                return Result<Bool, TestError>.success(true)
            }
            return Result<Bool, TestError>.failure(.timeout)
        }
        return await result.value
    }
}

struct ResultTest_Previews: PreviewProvider {
    static var previews: some View {
        ResultTest()
    }
}
