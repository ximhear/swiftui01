//
//  BingoCellView.swift
//  SwiftUI01
//
//  Created by we on 2023/05/09.
//

import SwiftUI

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

//struct BingoCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        BingoCellView()
//    }
//}
