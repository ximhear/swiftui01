//
//  ZStackTest.swift
//  SwiftUI01
//
//  Created by we on 2023/05/04.
//

import SwiftUI

struct ZStackTest: View {
    @State var size1: CGSize = .zero
    @State var size2: CGSize = .zero
    @State var offset: CGSize = .zero
    @State var move: Bool = false
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text(size1.dimension)
                Button("animate") {
                    withAnimation(.interpolatingSpring(stiffness: 29.9, damping: 0.95)) {
                        move = !move
                    }
                }
                ZStack(alignment: .bottomTrailing) {
                    Group {
                        Group {
                            Rectangle()
                                .fill(move ? .blue.opacity(0.3) : .red.opacity(0.3))
                                .frame(width: 100, height: 200)
                                .background(
                                    GeometryReader { proxy in
                                        Color.clear
                                            .preference(key: SizePreferenceKey.self, value: proxy.size)
                                    }
                                )
                                .scaleEffect(move ? .init(width: 0.5, height: 0.5) : .init(width: 1, height: 1), anchor: .bottomTrailing)
                                .offset(move ? .init(width: 100, height: 100) : .zero)
                                .onTapGesture {
                                    GZLogFunc("Rectangle")
                                }
                        }
                        .onPreferenceChange(SizePreferenceKey.self) { preferences in
                            self.size1 = preferences
                        }
                        Capsule()
                            .fill(.cyan.opacity(0.3))
                            .frame(width: 150, height: 200)
                            .offset(.init(width: 200, height: 100))
                            .onTapGesture {
                                GZLogFunc("Capsule")
                            }
                        Group {
                            Ellipse()
                                .fill(.orange.opacity(0.3))
                                .frame(width: 200, height: 250)
                                .offset(.init(width: 100, height: 100))
                                .onTapGesture {
                                    GZLogFunc("Ellipse")
                                }
                                .modifier(GetSizeModifier(size: $size2))
                        }
                    }
                }
                .background(.purple.opacity(0.2))
                Text(size2.dimension)
            }
            .background(.yellow .opacity(0.1))
        }
        .ignoresSafeArea(edges: [])
        .background(.green.opacity(0.1))
    }
}

struct ZStackTest_Previews: PreviewProvider {
    static var previews: some View {
        ZStackTest()
    }
}

