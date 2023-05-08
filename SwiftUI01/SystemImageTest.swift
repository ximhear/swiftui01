//
//  ImageTest.swift
//  SwiftUI01
//
//  Created by we on 2023/05/08.
//

import SwiftUI

struct SystemImageTest: View {
    var body: some View {
        VStack {
            Image(systemName: "square.and.arrow.up")
                .font(.largeTitle)
                .foregroundStyle(.purple, .red)
            Image(systemName: "flag.and.flag.filled.crossed")
                .renderingMode(.template)
                .foregroundStyle(.purple, .red)
                .font(.largeTitle)
            HStack {
                Image(systemName: "cloud.sun.rain.fill")
                    .renderingMode(.original)
                    .font(.largeTitle)
                    .padding()
                    .background(.black)
                    .clipShape(Circle())
                Image(systemName: "cloud.sun.rain.fill")
                    .renderingMode(.template)
                    .foregroundStyle(.red, .green, .yellow)
                    .font(.largeTitle)
                    .padding()
                    .background(.black)
                    .clipShape(Circle())
                Image(systemName: "cloud.sun.rain.fill")
                    .renderingMode(.template)
                    .foregroundColor(.yellow)
                    .font(.largeTitle)
                    .padding()
                    .background(.black)
                    .clipShape(Circle())
            }
            HStack {
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .renderingMode(.original)
                    .foregroundStyle(.cyan, .orange)
                    .font(.largeTitle)
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .renderingMode(.template)
                    .foregroundStyle(.cyan, .orange)
                    .font(.largeTitle)
            }
            HStack{
                Group {
                    Image(systemName: "chart.bar.fill", variableValue: 0.3)
                    Image(systemName: "chart.bar.fill", variableValue: 0.6)
                    Image(systemName: "chart.bar.fill", variableValue: 1.0)
                }
                .foregroundStyle(.red, .green, .blue)
            }
            .font(.system(.largeTitle))
        }
    }
}

struct SystemImageTest_Previews: PreviewProvider {
    static var previews: some View {
        SystemImageTest()
    }
}
