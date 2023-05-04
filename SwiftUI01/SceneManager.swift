//
//  SceneManager.swift
//  SwiftUI01
//
//  Created by we on 2023/05/04.
//

import SwiftUI

enum SceneType {
    case c1
    case c2
}
class SceneManager: ObservableObject {
    @Published var type: SceneType = .c1
    
    static let shared = SceneManager()
}
