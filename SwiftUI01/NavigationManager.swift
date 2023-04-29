//
//  NavigationManager.swift
//  SwiftUI01
//
//  Created by gzonelee on 2023/04/30.
//

import SwiftUI

class NavigationManager: ObservableObject {
    @Published var path: NavigationPath = .init([String]())
    
    init() {
    }
    
    func add(_ path: String) {
        self.path.append(path)
    }
}

