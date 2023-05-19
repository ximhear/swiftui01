//
//  DragGestureTest.swift
//  SwiftUI01
//
//  Created by we on 2023/05/19.
//

import SwiftUI

struct DragGestureTest: View {
    @State var drag: CGSize = .zero
    @State var lastLocation: CGPoint? = nil
    var body: some View {
        VStack {
            GeometryReader { proxy in
                ZStack {
                    Rectangle()
                        .fill()
                        .foregroundColor(.green.opacity(0.3))
                    Circle()
                        .stroke(lineWidth: 3)
                        .frame(width: 60, height: 60)
                        .offset(x: drag.width * proxy.size.width, y: drag.height * proxy.size.height)
                    UIViewWrap(drag: $drag)
                }
                .gesture(DragGesture()
                    .onChanged({ value in
                        if let lastLocation {
                            drag.width += (value.location.x - lastLocation.x) / proxy.size.width
                            drag.height += (value.location.y - lastLocation.y) / proxy.size.height
                        }
                        else {
                            drag.width += value.translation.width / proxy.size.width
                            drag.height += value.translation.height / proxy.size.height
                        }
                        self.lastLocation = value.location
                    }).onEnded({ value in
                        if let lastLocation {
                            drag.width += (value.location.x - lastLocation.x) / proxy.size.width
                            drag.height += (value.location.y - lastLocation.y) / proxy.size.height
                        }
                        else {
                            drag.width += value.translation.width / proxy.size.width
                            drag.height += value.translation.height / proxy.size.height
                        }
                        self.lastLocation = nil
                    }))
            }
            .background(.yellow)
            Text("\(drag.dimension)").lineLimit(1)
        }
    }
}

struct DragGestureTest_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureTest()
    }
}
