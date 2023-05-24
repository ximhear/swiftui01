//
//  GestureMain.swift
//  SwiftUI01
//
//  Created by we on 2023/05/24.
//

import SwiftUI

struct GestureMain: View {
    var body: some View {
        List {
            NavigationLink {
                MagnificationGestureTest()
            } label: {
                Text("Magnification")
            }
            NavigationLink {
                DragGestureTest()
            } label: {
                Text("Drag Gesture")
            }
        }
        .listStyle(.plain)
        .navigationTitle(Text("Gesture"))
    }
}

struct GestureMain_Previews: PreviewProvider {
    static var previews: some View {
        GestureMain()
    }
}
