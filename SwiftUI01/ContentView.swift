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
        }
    }
}

struct ContentView: View {
    @AppStorage("aaaValue") var value: Int = 0
    @StateObject var vm = ViewModel(value: 10)
    var body: some View {
        VStack {
            NavigationView {
                List {
                    NavigationLink {
                        ZStackTest()
                    } label: {
                        Text("ZStack")
                    }
                    NavigationLink {
                        AAAView()
                    } label: {
                        Text("AppStorage")
                    }
                    NavigationLink {
                        Test02(vm: vm)
                    } label: {
                        Text("NavigationStack")
                    }
                }
                .listStyle(.plain)
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
