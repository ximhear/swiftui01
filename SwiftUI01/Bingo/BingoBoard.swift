//
//  BingoBoard.swift
//  SwiftUI01
//
//  Created by we on 2023/05/09.
//

import Foundation

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
        return bingoCount >= 3
    }
    
    func mark(at index: Int) {
        board[index] = true
    }
}

extension BingoBoard {
    func isMarkedCellWinning(_ index: Int) -> Bool {
        let row = index / size
        let column = index % size
        
        // Check horizontal bingo
        var isHorizontalBingo = true
        for c in 0..<size {
            if !isMarked(at: row * size + c) {
                isHorizontalBingo = false
                break
            }
        }
        if isHorizontalBingo { return true }
        
        // Check vertical bingo
        var isVerticalBingo = true
        for r in 0..<size {
            if !isMarked(at: r * size + column) {
                isVerticalBingo = false
                break
            }
        }
        if isVerticalBingo { return true }
        
        // Check diagonal bingo
        if row == column {
            var isDiagonalBingo = true
            for i in 0..<size {
                if !isMarked(at: i * size + i) {
                    isDiagonalBingo = false
                    break
                }
            }
            if isDiagonalBingo { return true }
        }
        if row == size - column - 1 {
            var isDiagonalBingo = true
            for i in 0..<size {
                if !isMarked(at: i * size + (size - i - 1)) {
                    isDiagonalBingo = false
                    break
                }
            }
            if isDiagonalBingo { return true }
        }
        
        return false
    }
}
