//
//  ScrollViewTest.swift
//  SwiftUI01
//
//  Created by we on 2023/05/17.
//

import SwiftUI

struct ScrollViewTest: View {
    @State var values: [Int] = .init(repeating: 1, count: 10)
    let url: URL? = URL(string: "https://images.unsplash.com/photo-1541167760496-1628856ab772?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Y29mZmVlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60")
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(0...3, id: \.self) { value in
                        Text("\(value) \(value)")
                    }
                    .font(.title)
                    Image(systemName: "chart.bar.fill")
                        .font(.system(size: 250))
                        .scaledToFit()
                        .foregroundColor(.red)
                        .padding()
                        .id(100)
                    HStack(spacing: 0) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                        } placeholder: {
                            Color.green
                        }
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                        } placeholder: {
                            Color.green
                        }
                    }
                    .id(200)
                }
                .background(.green.opacity(0.1))
                Button("Go to") {
                    withAnimation {
                        proxy.scrollTo(100, anchor: .init(x: 0, y: 0.2))
                    }
                }
                .font(.title)
                .buttonStyle(.bordered)
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0...100, id: \.self) { value in
                        Text("\(value)")
                    }
                    .font(.title)
                }
                .background(.yellow)
            }
            .padding()
            .background(.orange.opacity(0.1))
        }
    }
}

struct ScrollViewTest_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewTest()
    }
}
