//
//  AsyncImageTest.swift
//  SwiftUI01
//
//  Created by we on 2023/05/09.
//

import SwiftUI

struct AsyncImageTest: View {
    let url: URL? = URL(string: "https://images.unsplash.com/photo-1541167760496-1628856ab772?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Y29mZmVlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60")
    var body: some View {
        VStack(spacing: 0) {
//            AsyncImage(url: url)
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.green
            }
            AsyncImage(url: url, scale: 2, transaction: .init(animation: .easeInOut(duration: 3))) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Color.red // Indicates an error.
                } else {
                    Color.blue // Acts as a placeholder.
                }
            }
            AsyncImage(url: url) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Color.red // Indicates an error.
                } else {
                    Color.blue // Acts as a placeholder.
                }
            }
        }
    }
}

struct AsyncImageTest_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageTest()
    }
}
