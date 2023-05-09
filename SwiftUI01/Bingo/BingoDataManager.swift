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
    typealias ReceivedBlock = (BingoData) -> Void
    var vms: [BingoGameViewModel] = []
    let subject = PassthroughSubject<BingoData, Never>.init()
    var cancellable: AnyCancellable?
    
    deinit {
        GZLogFunc()
    }
    
    init() {
        GZLogFunc()
    }
    
    func run(received: ReceivedBlock?) {
        cancellable = subject.sink { data in
            GZLogFunc(data)
            received?(data)
        }

        for x in vms {
            x.subject = subject
            x.runSubject()
        }
    }
}

