//
//  BingoCellViewModel.swift
//  SwiftUI01
//
//  Created by we on 2023/05/09.
//

import Foundation
 
class BingoCellViewModel: ObservableObject, Identifiable {
    let text: String
    @Published var isMarked = false
    var id: Int
    
    var displayText: String {
        return text
//        return isMarked ? "✅" : text
    }
    
    init(text: String) {
        self.text = text
        self.id = 0
    }
    
    func didTap() {
        // Do something when cell is tapped
    }
}

