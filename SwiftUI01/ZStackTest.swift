//
//  ZStackTest.swift
//  SwiftUI01
//
//  Created by we on 2023/05/04.
//

import SwiftUI

struct ZStackTest: View {
    @State var size: CGSize = .zero
    @State var offset: CGSize = .zero
    @State var move: Bool = false
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text(size.dimension)
                Button("animate") {
                    withAnimation(.interpolatingSpring(stiffness: 29.9, damping: 0.3)) {
                        move = !move
                    }
                }
                ZStack {
                    GeometryReader { proxy in
                        Rectangle()
                            .fill(move ? .blue.opacity(0.3) : .red.opacity(0.3))
                            .frame(width: 100, height: 200)
                            .background(
                                GeometryReader { proxy in
                                    Color.clear
                                        .preference(key: SizePreferenceKey.self, value: proxy.size)
                                }
                            )
                            .offset(move ? .init(width: 100, height: 100) : .zero)
                        Capsule()
                            .fill(.cyan.opacity(0.3))
                            .frame(width: 100, height: 200)
                            .offset(.init(width: 200, height: 100))
                        Ellipse()
                            .fill(.orange.opacity(0.3))
                            .frame(width: 100, height: 200)
                            .offset(.init(width: 100, height: 100))
                            .onTapGesture {
                                GZLogFunc()
                            }
                    }
                }
                .background(.purple.opacity(0.2))
                .onPreferenceChange(SizePreferenceKey.self) { preferences in
                    self.size = preferences
                }
                Text(size.dimension)
            }
            .background(.yellow .opacity(0.1))
        }
        .ignoresSafeArea(edges: [])
        .background(.green.opacity(0.1))
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

extension CGSize {
    var dimension: String {
        "\(self.width) x \(height)"
    }
}

struct ZStackTest_Previews: PreviewProvider {
    static var previews: some View {
        ZStackTest()
    }
}
