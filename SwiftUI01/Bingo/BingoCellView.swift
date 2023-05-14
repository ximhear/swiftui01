//
//  BingoCellView.swift
//  SwiftUI01
//
//  Created by we on 2023/05/09.
//

import SwiftUI

struct BingoCellView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: BingoCellViewModel
    let borderWidth: Double = 1
    let cornerRadius: Double = 8
    
    var body: some View {
        Text(viewModel.displayText)
            .font(.headline)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(4)
            .background(viewModel.isMarked ? markColor : defaultBgColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth))
    }
    
    var defaultBgColor: Color {
        colorScheme == .dark ? .black : .white
    }
    
    var borderColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var markColor: Color {
        colorScheme == .dark ? Color(red: 0, green: 0.5, blue: 0) : .green
    }
}

struct BingoCellView_Previews: PreviewProvider {
    static var vm = BingoCellViewModel(text: "Hello")
    static var previews: some View {
        BingoCellView(viewModel: vm)
            .padding(40)
    }
}
