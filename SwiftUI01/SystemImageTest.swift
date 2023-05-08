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
            Image(systemName: "multiply")
                  .symbolVariant(.circle.fill)
                  .font(.system(.largeTitle))
            HStack {
                Group {
                    Image(systemName: "cloud.sun.rain.fill")
                        .symbolRenderingMode(.monochrome)
                    Image(systemName: "cloud.sun.rain.fill")
                        .symbolRenderingMode(.hierarchical)
                    Image(systemName: "cloud.sun.rain.fill")
                        .symbolRenderingMode(.palette)
                    Image(systemName: "cloud.sun.rain.fill")
                        .symbolRenderingMode(.multicolor)
                }
                .foregroundStyle(.cyan, .green, .red)
                .font(.largeTitle)
            }
            .padding()
            .background(.black.opacity(0.9))
            VStack {
                Group {
                    Group {
                        HStack() {
                            Image(systemName: "menucard")
                                .font(.largeTitle)
                            Text("SF Symbols")
                                .font(.callout)
                        }
                        HStack(alignment: .firstTextBaseline) {
                            Image(systemName: "menucard")
                                .font(.largeTitle)
                            Text("SF Symbols")
                                .font(.callout)
                        }
                    }
                    HStack() {
                        Image(systemName: "menucard")
                        Text("SF Symbols\nSF Symbols")
                            .multilineTextAlignment(.leading)
                    }
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: "menucard")
                        Text("SF Symbols\nSF Symbols")
                            .multilineTextAlignment(.leading)
                    }
                    HStack(alignment: .lastTextBaseline) {
                        Image(systemName: "menucard")
                        Text("SF Symbols\nSF Symbols")
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(4)
            }
            .font(.title)
        }
    }
}

struct SystemImageTest_Previews: PreviewProvider {
    static var previews: some View {
        SystemImageTest()
    }
}
