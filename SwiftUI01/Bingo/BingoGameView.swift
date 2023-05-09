//
//  BingoGameView.swift
//  SwiftUI01
//
//  Created by we on 2023/05/09.
//

import SwiftUI
import Foundation
import Combine


struct BingoGameView: View {
    @ObservedObject var viewModel: BingoGameViewModel
    
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
        .alert(isPresented: $viewModel.showingWinAlert) {
            Alert(title: Text("Congratulations!"), message: Text("You won the game!"), dismissButton: .default(Text("OK")))
        }
    }
}

