//
//  BingoDataManager.swift
//  SwiftUI01
//
//  Created by we on 2023/05/09.
//

import Foundation
import Combine
import SwiftUI

class BingoDataManager: ObservableObject {
    var vms: [BingoGameViewModel] = []
    let subject = PassthroughSubject<BingoData, Never>.init()
    var subscriptions = Set<AnyCancellable>()
    
    deinit {
        GZLogFunc()
    }
    
    init() {
        GZLogFunc()
    }
    
    func run(received: @escaping (BingoData) -> Void) {
        subject.sink { data in
            GZLogFunc(data)
            received(data)
        }
        .store(in: &subscriptions)
        
        for x in vms {
            x.subject = subject
            x.runSubject()
        }
    }
}

