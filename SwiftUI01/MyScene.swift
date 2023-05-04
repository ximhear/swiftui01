//
//  MyScene.swift
//  SwiftUI01
//
//  Created by we on 2023/05/04.
//

import SwiftUI

struct MyScene<Content>: Scene where Content: View {
    let content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
        
    }
    var body: some Scene {
        WindowGroup {
            content()
        }
    }
}
