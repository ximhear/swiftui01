//
//  MagnificationGestureTest.swift
//  SwiftUI01
//
//  Created by we on 2023/05/24.
//

import SwiftUI

struct MagnificationGestureTest: View {
    @State private var scale1: CGFloat = 1
    @State private var scale2: CGFloat = 1
    @GestureState private var amount1: CGFloat = 1
    @State private var amount2: CGFloat = 1
    
    @State private var scale3: CGFloat = 1
    @GestureState private var amount3: CGFloat = 1
    
    var body: some View {
        VStack {
            Text("\(amount1 * scale1)")
                .zIndex(1)
            Image("image01")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(scale1 * amount1)
                .gesture(
                    MagnificationGesture().updating($amount1) { (value, state, _) in
                        GZLogFunc(value)
                        state = value
                    }.onEnded { (value) in
                        // magniture는 절대값을 리턴해준다.
                        GZLogFunc(value.magnitude)
                        scale1 = scale1 * value.magnitude
                    }
                )
            Divider()
                .padding()
            Text("limit \(amount3 * scale3)")
                .zIndex(1)
            Image("image01")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(scale3 * amount3)
                .gesture(
                    MagnificationGesture().updating($amount3) { (value, state, _) in
                        GZLogFunc(value)
                        let scale = min(max(scale3 * value, 0.5), 3.0)
                        state = scale / scale3
                    }.onEnded { (value) in
                        GZLogFunc(value)
                        scale3 = min(max(scale3 * value, 0.5), 3.0)
                    }
                )
            Divider()
                .padding()
            Text("\(scale2 * amount2)")
                .zIndex(1)
            Image("image01")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(scale2 * amount2)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            GZLogFunc(value.magnitude)
                            self.amount2 = value.magnitude
                        }
                        .onEnded { value in
                            self.scale2 *= value.magnitude
                            self.amount2 = 1.0
                        }
                )
        }
    }
}

struct MagnificationGestureTest_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureTest()
    }
}
