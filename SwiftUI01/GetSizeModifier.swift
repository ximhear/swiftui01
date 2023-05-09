//
//  GetSizeModifier.swift
//  SwiftUI01
//
//  Created by we on 2023/05/04.
//

import SwiftUI

struct GetSizeModifier: ViewModifier {
    var size: Binding<CGSize>
    init(size: Binding<CGSize>) {
        self.size = size
    }
   
    func body(content: Content) -> some View {
        Group {
            Group {
                content
            }
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: proxy.size)
                }
            )
        }
        .onPreferenceChange(SizePreferenceKey.self) { preferences in
            self.size.wrappedValue = preferences
        }
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

