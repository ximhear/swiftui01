//
//  ComputerPlayer.swift
//  SwiftUI01
//
//  Created by we on 2023/05/09.
//

import Foundation

class ComputerPlayer: ObservableObject {
    var viewModel: BingoGameViewModel?
    
    func takeTurn() {
        guard let viewModel else {
            return
        }
        // First, check if any cell will complete a bingo
        for cellViewModel in viewModel.cellViewModels {
            if !cellViewModel.isMarked && viewModel.bingoBoard.isMarkedCellWinning(cellViewModel.id) {
                viewModel.didTapCell(at: cellViewModel.id)
                return
            }
        }
        
        // If no cell completes a bingo, choose a random unmarked cell
        let unmarkedCellViewModels = viewModel.cellViewModels.filter { !$0.isMarked }
        guard let randomCellViewModel = unmarkedCellViewModels.randomElement() else { return }
        viewModel.didTapCell(at: randomCellViewModel.id)
    }
}


