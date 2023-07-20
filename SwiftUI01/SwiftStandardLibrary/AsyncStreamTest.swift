//
//  AsyncStreamTest.swift
//  SwiftUI01
//
//  Created by gzonelee on 2023/07/20.
//

import SwiftUI
import Combine

class AsyncStreamWrapper: ObservableObject {
    var timer = Timer.publish(every: 2, on: .main, in: .common)
    var cancellable: AnyCancellable?
    var dateUpdated: (Date) -> Void = {_ in }
    var finishUpdating: () -> Void = { }
    lazy var dateStream: AsyncStream<Date> = {
        AsyncStream {[weak self] continuation in
            guard let self else { return }
            dateUpdated = { date in
                continuation.yield(date)
            }
            finishUpdating = {
                continuation.finish()
            }
        }
    }()
    
    init() {
        GZLogFunc()
    }
    
    func monitor() {
        GZLogFunc()
        cancellable = timer.sink { r in
        } receiveValue: {[weak self] d in
            guard let self else { return }
            GZLogFunc(d)
            dateUpdated(d)
        }
        _ = timer.connect()
    }
    
    func stopMonitor() {
        finishUpdating()
        if let cancellable {
            cancellable.cancel()
        }
        cancellable = nil
    }
    
    deinit {
        GZLogFunc()
    }
    
}

struct AsyncStreamTest: View {
    
    @StateObject var ooo = AsyncStreamWrapper()
    @State var date: Date = .now
    
    var body: some View {
        VStack {
            Text("\(date)")
        }
        .onAppear {
            ooo.monitor()
            Task {
                for await value in ooo.dateStream {
                    GZLogFunc(value)
                    Task { @MainActor in
                        date = value
                    }
                }
            }
        }
        .onDisappear {
            ooo.stopMonitor()
        }
    }
}

#Preview {
    AsyncStreamTest()
}
