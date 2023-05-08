//
//  ImageTest.swift
//  SwiftUI01
//
//  Created by we on 2023/05/08.
//

import SwiftUI

struct ImageTest: View {
    @State var imageSize: CGSize = .zero
    @State var zstackSize: CGSize = .zero
    let borderWidth: Double = 4
    var body: some View {
        VStack {
            HStack {
                Image("image01")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipped()
                    .background(.red)
                Image("image01")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
                    .background(.red)
            }
            
            HStack {
                Group {
                    Image("image01")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image("image01")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fill)
                    Image("image01")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            // border의 width 수치는 control 내부로 향하는 굵기이다.
            // 내부로 0.5, 외부로 0.5가 아니라 전체가 내부로 향한다.
                .border(.green.opacity(0.25), width: 20)
                .background(.red.opacity(0.2))
            }
            Image("image01")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .modifier(GetSizeModifier(size: $imageSize))
                .clipShape(Circle())
                .overlay {
                    Circle()
                    // stroke는 내부로 0.5, 외부로 0.5 향한다.
                        .stroke(style: .init(lineWidth: borderWidth))
                        .foregroundColor(.red.opacity(0.9))
                        .frame(width: imageSize.width - borderWidth, height: imageSize.height - borderWidth)
                }
//            ZStack(alignment: .topLeading) {
//                Rectangle()
//                    .fill(Color.green.opacity(0.5))
//                    .border(.red.opacity(0.3), width: 10)
//                    .frame(width: 100, height: 100)
//                Rectangle()
//                    .frame(width: 10, height: 10)
//            }
//            .modifier(GetSizeModifier(size: $zstackSize))
//            .overlay(Circle().stroke(style: .init(lineWidth: 10))
//                .foregroundColor(.red.opacity(0.3))
//            )
            Image("image01")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Image("image01")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}

struct ImageTest_Previews: PreviewProvider {
    static var previews: some View {
        ImageTest()
    }
}
