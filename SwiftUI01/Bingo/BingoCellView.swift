//
//  BingoCellView.swift
//  SwiftUI01
//
//  Created by we on 2023/05/09.
//

import SwiftUI

struct BingoCellView: View {
    @ObservedObject var viewModel: BingoCellViewModel
    let borderWidth: Double = 1
    let cornerRadius: Double = 8
    
    var body: some View {
        Text(viewModel.displayText)
            .font(.headline)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(4)
            .background(viewModel.isMarked ? Color.green : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.black, lineWidth: borderWidth))
    }
}

struct BingoCellView_Previews: PreviewProvider {
    static var vm = BingoCellViewModel(text: "Hello")
    static var previews: some View {
        BingoCellView(viewModel: vm)
            .padding(40)
    }
}
