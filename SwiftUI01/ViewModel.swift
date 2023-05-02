//
//  ViewModel.swift
//  SwiftUI01
//
//  Created by gzonelee on 2023/05/03.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var value: Int
    
    init(value: Int) {
        self.value = value
    }
    
    func inc() {
        value &+= 10
    }
}
