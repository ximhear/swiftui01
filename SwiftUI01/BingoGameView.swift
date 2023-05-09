//
//  BingoGameView.swift
//  SwiftUI01
//
//  Created by we on 2023/05/09.
//

import SwiftUI
import Foundation

class BingoCellViewModel: ObservableObject, Identifiable {
    let text: String
    @Published var isMarked = false
    var id: Int
    
    var displayText: String {
        return isMarked ? "✅" : text
    }
    
    init(text: String) {
        self.text = text
        self.id = 0
    }
    
    func didTap() {
        // Do something when cell is tapped
    }
}

class BingoBoard {
    let size = 5
    var originalWords = [String]()
    var words = [String]()
    private var board = [Bool](repeating: false, count: 25)
    
    var bingoCount: Int {
        var count = 0
        
        // check rows
        for i in stride(from: 0, to: size * size, by: size) {
            var rowBingo = true
            
            for j in i..<i+size {
                if !board[j] {
                    rowBingo = false
                    break
                }
            }
            
            if rowBingo {
                count += 1
            }
        }
        
        // check columns
        for i in 0..<size {
            var colBingo = true
            
            for j in stride(from: i, to: size * size, by: size) {
                if !board[j] {
                    colBingo = false
                    break
                }
            }
            
            if colBingo {
                count += 1
            }
        }
        
        // check diagonal from top-left to bottom-right
        var diagonal1Bingo = true
        for i in stride(from: 0, to: size * size, by: size + 1) {
            if !board[i] {
                diagonal1Bingo = false
                break
            }
        }
        if diagonal1Bingo {
            count += 1
        }
        
        // check diagonal from bottom-left to top-right
        var diagonal2Bingo = true
        for i in stride(from: size - 1, to: size * size - size, by: size - 1) {
            if !board[i] {
                diagonal2Bingo = false
                break
            }
        }
        if diagonal2Bingo {
            count += 1
        }
        
        return count
    }
    
    var isGameOver: Bool {
        return bingoCount >= 3
    }
    
    var isBoardFull: Bool {
        return !board.contains(false)
    }
    
    var isWinning: Bool {
        return isBoardFull || isGameOver
    }
    
    init() {
        self.originalWords = ["hello", "world", "swift", "apple", "google", "facebook", "twitter", "instagram", "youtube", "amazon", "netflix", "microsoft", "tesla", "coca cola", "pepsi", "nike", "adidas", "puma", "gucci", "prada", "chanel", "louis vuitton", "ferrari", "rolls royce", "coffee"]
        self.words = ["hello", "world", "swift", "apple", "google", "facebook", "twitter", "instagram", "youtube", "amazon", "netflix", "microsoft", "tesla", "coca cola", "pepsi", "nike", "adidas", "puma", "gucci", "prada", "chanel", "louis vuitton", "ferrari", "rolls royce", "coffee"]
    }
    
    func shuffleBoard() {
        var indexes = [Int](0..<originalWords.count)
        indexes.shuffle()
        
        for i in 0..<board.count {
            if i < indexes.count {
                let index = indexes[i]
                board[i] = false
                words[i] = originalWords[index]
            }
        }
    }
    
    func isMarked(at index: Int) -> Bool {
        return board[index]
    }
    
    func headerText(for column: Int) -> String {
        return String(column + 1)
    }
    
    func isBingo() -> Bool {
        let bingoCount = self.bingoCount
        return bingoCount > 0 && bingoCount <= 3
    }
    
    func mark(at index: Int) {
        board[index] = true
    }
}


class BingoGameViewModel: ObservableObject {
    @Published var cellViewModels = [BingoCellViewModel]()
    @Published var showingWinAlert = false
    
    private let bingoBoard = BingoBoard()
    
    var boardSize: Int {
        return bingoBoard.size
    }
    
    init() {
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
        
        cellViewModels[index].isMarked = true
        bingoBoard.mark(at: index)
        
        if bingoBoard.isBingo() {
            if bingoBoard.bingoCount == 3 {
                showingWinAlert = true
            }
        }
    }
    
    func headerText(for column: Int) -> String {
        return bingoBoard.headerText(for: column)
    }
}

struct BingoGameView: View {
    @StateObject var viewModel: BingoGameViewModel = .init()
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<viewModel.boardSize) { column in
                    Text(viewModel.headerText(for: column))
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(Color.yellow)
                }
            }
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(0..<viewModel.boardSize) { row in
                        HStack(spacing: 0) {
                            ForEach(0..<viewModel.boardSize) { column in
                                BingoCellView(viewModel: viewModel.cellViewModels[row * viewModel.boardSize + column])
                                    .onTapGesture {
                                        viewModel.didTapCell(at: row * viewModel.boardSize + column)
                                    }
                            }
                        }
                    }
                }
            }
            Button("New game") {
                viewModel.initialize()
            }
        }
        .alert(isPresented: $viewModel.showingWinAlert) {
            Alert(title: Text("Congratulations!"), message: Text("You won the game!"), dismissButton: .default(Text("OK")))
        }
    }
}

struct BingoCellView: View {
    @ObservedObject var viewModel: BingoCellViewModel
    
    var body: some View {
            Text(viewModel.displayText)
                .font(.headline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(8)
                .background(viewModel.isMarked ? Color.green : Color.white)
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1))
    }
}

