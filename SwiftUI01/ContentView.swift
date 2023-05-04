//
//  ContentView.swift
//  SwiftUI01
//
//  Created by gzonelee on 2023/04/30.
//

import SwiftUI

struct AAAView: View {
    @AppStorage("aaaValue") var value: Int = 0
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.title)
            Button("inc") {
                value &+= 1
            }
            ContentView()
        }
    }
}

struct ContentView: View {
    @AppStorage("aaaValue") var value: Int = 0
    @StateObject var vm = ViewModel(value: 10)
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
                        Test02(vm: vm)
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
            .onAppear {
                GZLogFunc()
            }
            .onDisappear {
                GZLogFunc()
            }
            .task {
                GZLogFunc()
            }
            Test02(vm: vm)
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            hello()
        }
        .padding()
    }
    
    @ViewBuilder func hello() -> some View {
        if value % 2 == 0 {
            Text("Hello 0")
            Image(systemName: "star")
                .foregroundColor(.red)
        }
        else {
            Image(systemName: "star")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
