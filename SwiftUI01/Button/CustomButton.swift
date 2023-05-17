//
//  CustomButton.swift
//  SwiftUI01
//
//  Created by we on 2023/05/17.
//

import SwiftUI

struct CustomButton<Content: View>: View {
    let action: () -> Void
    let content: Content

    init(action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.action = action
        self.content = content()
    }

    var body: some View {
        self.content
        .foregroundColor(.white)
        .font(.title)
        .padding()
        .background(.orange)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(lineWidth: 3))
        .onTapGesture {
            action()
        }
    }
}


struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton {
            GZLogFunc()
        } content: {
            Text("Hello")
        }

    }
}
