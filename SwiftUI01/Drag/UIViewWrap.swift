//
//  UIViewWrap.swift
//  SwiftUI01
//
//  Created by we on 2023/05/19.
//

import SwiftUI

struct UIViewWrap: UIViewRepresentable {
    @Binding var drag: CGSize
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .yellow
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = "\(drag.dimension)"
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($drag)
    }
    
    class Coordinator {
        @Binding var drag: CGSize
        
        init(_ drag: Binding<CGSize>) {
            _drag = drag
        }
    }
}
