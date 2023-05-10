//
//  BingoPlayground.swift
//  SwiftUI01
//
//  Created by we on 2023/05/09.
//

import SwiftUI
import Combine

struct BingoPlayground: View {
    @StateObject var vmUser: BingoGameViewModel
    @StateObject var vmComputer: BingoGameViewModel
    @StateObject var manager: BingoDataManager
    @StateObject var computer: ComputerPlayer
    @State var player: BingoPlayer = .user
    
    init() {
        _vmUser = StateObject(wrappedValue: .init(player: .user))
        _vmComputer = StateObject(wrappedValue: .init(player: .computer))
        _manager = StateObject(wrappedValue: .init())
        _computer = StateObject(wrappedValue: .init())
    }
    
    var body: some View {
        VStack {
            BingoGameView(viewModel: vmUser)
                .disabled(player == .computer || manager.bingoResult != .none)
                .overlay(player == .computer ? Color.red.opacity(0.3) : Color.clear)
            BingoGameView(viewModel: vmComputer)
                .disabled(player == .user)
                .overlay(player == .user ? Color.red.opacity(0.3) : Color.green.opacity(0.1))
                .overlay(Color.green.opacity(0.1))
            Button("New game") {
                let who = [0, 1].shuffled()[0]
                if who == 0 {
                    player = .user
                }
                else {
                    player = .computer
                }
                manager.initialize()
                vmUser.initialize()
                vmComputer.initialize()
            }
        }
        .alert(isPresented: $manager.showingWinAlert) {
            let messageText: String
            switch manager.bingoResult {
            case .both:
                messageText = "You and Computer won the game!"
            case .computer:
                messageText = "Computer won the game!"
            case .user:
                messageText = "You won the game!"
            case .none:
                messageText = ""
            }
            return Alert(title: Text("Congratulations!"), message: Text(messageText), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            GZLogFunc("onAppear")
            computer.viewModel = vmComputer
            manager.run(vmUser: vmUser, vmComputer: vmComputer) { data in
                if data.player == .user {
                    player = .computer
                }
                else {
                    player = .user
                }
            }
        }
        .onDisappear {
            GZLogFunc("onDisappear")
            manager.cancellable?.cancel()
            manager.finishedCancellable?.cancel()
            vmUser.cancellable?.cancel()
            vmComputer.cancellable?.cancel()
            manager.cancellable = nil
            manager.finishedCancellable = nil
            vmUser.cancellable = nil
            vmComputer.cancellable = nil
        }
        .onChange(of: player) { newValue in
            GZLogFunc(newValue)
            if newValue == .computer {
                Task {
                    do {
                        try await Task.sleep(for: .seconds(0.5))
                    } catch {
                    }
                    await MainActor.run {
                        computer.takeTurn()
                    }
                }
            }
        }
    }
}

struct BingoPlayground_Previews: PreviewProvider {
    static var previews: some View {
        BingoPlayground()
    }
}
