//
//  ShaderMain.swift
//  SwiftUI01
//
//  Created by gzonelee on 2023/07/24.
//

import SwiftUI
import simd

struct ShaderMain: View {
    let colors: [Color] = [.red, .green, .blue]
    @State var size: CGSize = .zero
    var body: some View {
        VStack(spacing: 4) {
            Rectangle()
                .foregroundColor(.purple)
                .colorEffect(Shader(function: .init(library: .default, name: "colorEffect"), arguments: []))
            ZStack {
                ForEach(0..<colors.count, id: \.self) { index in
                    Rectangle()
                        .foregroundColor(colors[index])
                        .distortionEffect(Shader(function: .init(library: .default, name: "distortEffect"), arguments: [
                            .float2(
                                rotation(.init(degrees: Double(index) * 10)).columns.0.x,
                                rotation(.init(degrees: Double(index) * 10)).columns.0.y
                            ),
                            .float2(
                                rotation(.init(degrees: Double(index) * 10)).columns.1.x,
                                rotation(.init(degrees: Double(index) * 20)).columns.1.y
                            )
                        ]), maxSampleOffset: .init(width: 1, height: 1))
                }
            }
            ZStack(alignment: .topLeading) {
                HStack(spacing: 0) {
                    ForEach(0..<colors.count, id: \.self) { index in
                        VStack(spacing: 0) {
                            Rectangle()
                                .foregroundColor(colors[index])
                            Rectangle()
                                .foregroundColor(.yellow.opacity(1.0))
                            Rectangle()
                                .foregroundColor(.cyan.opacity(1.0))
                            Rectangle()
                                .foregroundColor(.purple.opacity(1.0))
                        }
                        .layerEffect(Shader(function: .init(library: .default, name: "layerEffect"), arguments: [
                            .float(1),
                            .float(240)]),
                                     maxSampleOffset: .init(width: 200, height: 300))
                    }
                }
                VStack(spacing: 0) {
                    Rectangle()
                        .foregroundColor(.red.opacity(0.1))
                    Rectangle()
                        .foregroundColor(.blue.opacity(0.1))
                    Rectangle()
                        .foregroundColor(.cyan.opacity(0.1))
                    Rectangle()
                        .foregroundColor(.purple.opacity(0.1))
                }
                .modifier(GetSizeModifier(size: $size))
                Rectangle()
                    .stroke()
                    .frame(maxWidth: 100, maxHeight: 100)
                Text("\(size.width), \(size.height)")
            }
        }
//        .padding()
    }
    
    func rotation(_ angle: Angle) -> simd_float2x2 {
        let radian = Float(angle.radians)
        
        return .init(columns: (
            simd_float2(cos(radian), sin(radian)),
            simd_float2(-sin(radian), cos(radian))
        ))
    }
    
    var rotationMatrix: simd_float2x2 {
        return rotation(.init(degrees: 50))
    }
    
    
    
}


#Preview {
    ShaderMain()
}
