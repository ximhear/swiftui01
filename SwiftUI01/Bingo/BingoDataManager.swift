//
//  BingoDataManager.swift
//  SwiftUI01
//
//  Created by we on 2023/05/09.
//

import Foundation
import Combine
import SwiftUI

enum BingoGameWinner {
    case user
    case computer
    case both
    case none
}

class BingoDataManager: ObservableObject {
    typealias ReceivedBlock = (BingoData) -> Void
    let subject = PassthroughSubject<BingoData, Never>.init()
    var cancellable: AnyCancellable?
    var finishedCancellable: AnyCancellable?
    @Published var bingoResult: BingoGameWinner = .none
    @Published var showingWinAlert: Bool = false
    
    deinit {
        GZLogFunc()
    }
    
    init() {
        GZLogFunc()
    }
    
    func initialize() {
        bingoResult = .none
    }
    
    func run(vmUser: BingoGameViewModel, vmComputer: BingoGameViewModel, received: ReceivedBlock?) {
        let vms = [vmUser, vmComputer]
        for x in vms {
            x.subject = subject
            x.bingoSublect = .init()
            x.runSubject()
        }
        finishedCancellable = vmUser.bingoSublect.zip(vmComputer.bingoSublect).zip(subject)
            .sink {[weak self] result in
                GZLogFunc(result)
                guard let self else {
                    return
                }
                if bingoResult != .none {
                    return
                }
                if result.0.0 {
                    bingoResult = result.0.1 ? .both : .user
                    showingWinAlert = true
                }
                else if result.0.1 {
                    bingoResult = .computer
                    showingWinAlert = true
                }
                else {
                    bingoResult = .none
                    received?(result.1)
                }
            }
    }
}

