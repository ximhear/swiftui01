//
//  BingoPlayground.swift
//  SwiftUI01
//
//  Created by we on 2023/05/09.
//

import SwiftUI
import Combine

struct BingoPlayground: View {
    @Environment(\.colorScheme) var colorScheme
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
                .overlay(player == .computer ? overlayColor : Color.clear)
            BingoGameView(viewModel: vmComputer)
                .disabled(player == .user)
                .overlay(player == .user ? overlayColor : Color.green.opacity(0.1))
                .overlay(colorScheme == .light ? Color.green.opacity(0.1) : Color.gray.opacity(0.1))
            Button("New game") {
                manager.initialize()
                vmUser.initialize()
                vmComputer.initialize()
                let who = [0, 1].shuffled()[0]
                let oldPlayer = player
                if who == 0 {
                    player = .user
                }
                else {
                    player = .computer
                    if oldPlayer == player {
                        doComputer()
                    }
                }
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
                doComputer()
            }
        }
    }
    
    private func doComputer() {
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
    
    private var overlayColor: Color {
        if colorScheme == .light {
            return Color.red.opacity(0.3)
        }
        return Color.gray.opacity(0.3)
    }
}

struct BingoPlayground_Previews: PreviewProvider {
    static var previews: some View {
        BingoPlayground()
    }
}
