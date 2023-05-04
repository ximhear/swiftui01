//
//  SwiftUI01App.swift
//  SwiftUI01
//
//  Created by gzonelee on 2023/04/30.
//

import SwiftUI

@main
struct SwiftUI01App: App {
    @ObservedObject var sceneManager: SceneManager = .shared
    var body: some Scene {
//        if sceneManager.type == .c1 {
            MyScene {
                AAAView()
            }
//        }
//        else {
//            MyScene {
//                AAAView()
//            }
//        }
    }
}
