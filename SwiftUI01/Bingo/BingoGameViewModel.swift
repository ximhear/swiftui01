//
//  BingoGameViewModel.swift
//  SwiftUI01
//
//  Created by we on 2023/05/09.
//

import Foundation
import Combine

class BingoGameViewModel: ObservableObject {
    static var value: Int = 0
    @Published var cellViewModels = [BingoCellViewModel]()
    @Published var showingWinAlert = false
    var subject: PassthroughSubject<BingoData, Never>?
    var cancellable: AnyCancellable?
    let player: BingoPlayer
    var value: Int
    
    let bingoBoard = BingoBoard()
    
    deinit {
        GZLogFunc(value)
    }
    
    var boardSize: Int {
        return bingoBoard.size
    }
    
    init(player: BingoPlayer) {
        GZLogFunc()
        Self.value += 1
        value = Self.value
        self.player = player
        self.initialize()
    }
    
    func initialize() {
        bingoBoard.shuffleBoard()
        
        if cellViewModels.isEmpty {
            for word in bingoBoard.words {
                let cellViewModel = BingoCellViewModel(text: word)
                cellViewModels.append(cellViewModel)
            }
        }
        else {
            for (index, word) in bingoBoard.words.enumerated() {
                let cellViewModel = BingoCellViewModel(text: word)
                cellViewModels[index] = cellViewModel
            }
        }
        
        
        for index in 0..<cellViewModels.count {
            cellViewModels[index].id = index
            cellViewModels[index].isMarked = bingoBoard.isMarked(at: index)
        }
    }
    
    func didTapCell(at index: Int) {
        guard !cellViewModels[index].isMarked else { return }
        
        if let subject {
            subject.send(.init(player: player, text: cellViewModels[index].text))
        }
        
        changeMark(at: index)
    }
    
    func changeMark(at index: Int) {
        cellViewModels[index].isMarked = true
        bingoBoard.mark(at: index)
        
        if bingoBoard.isBingo() {
            if bingoBoard.bingoCount == 3 {
                showingWinAlert = true
            }
        }
    }
    
    private func findIndex(text: String) -> Int? {
        for (index, x) in cellViewModels.enumerated() {
            if x.text == text {
                return index
            }
        }
        return nil
    }
    
    func runSubject() {
        guard let subject else {
            return
        }
        let player = self.player
        cancellable = subject.sink {[weak self] data in
            GZLogFunc(data)
            guard let self else {
                return
            }
            if data.player == player {
                return
            }
            if let index = findIndex(text: data.text) {
                changeMark(at: index)
            }
        }
    }
    
    func headerText(for column: Int) -> String {
        return bingoBoard.headerText(for: column)
    }
}
