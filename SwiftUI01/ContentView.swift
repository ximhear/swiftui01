//
//  ContentView.swift
//  SwiftUI01
//
//  Created by gzonelee on 2023/04/30.
//

import SwiftUI

struct ContentView: View {
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
                        AppStorageTest()
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
