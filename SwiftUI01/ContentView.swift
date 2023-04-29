//
//  ContentView.swift
//  SwiftUI01
//
//  Created by gzonelee on 2023/04/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    NavigationLink {
                        Test01()
                    } label: {
                        Text("Test01")
                    }
                    NavigationLink {
                        Test02()
                    } label: {
                        Text("Test02")
                    }
                    NavigationStack {
                        Group {
                            NavigationLink("Test01", value: "hello")
                            NavigationLink("Text", value: "great")
                        }
                        .navigationDestination(for: String.self) { value in
                            Text(value)
                        }
                    }
                }
            }
            Test02()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
