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
                    Group {
                        NavigationLink {
                            GestureMain()
                        } label: {
                            Text("Gesture")
                        }
                        NavigationLink {
                            ScrollViewTest()
                        } label: {
                            Text("ScrollView")
                        }
                        NavigationLink {
                            FontTest()
                        } label: {
                            Text("Text")
                        }
                        NavigationLink {
                            GGGView()
                        } label: {
                            Text("Bingo")
                        }
                        NavigationLink {
                            ButtonTest()
                        } label: {
                            Text("Button")
                        }
                    }
                    NavigationLink {
                        AsyncImageTest()
                    } label: {
                        Text("Async Image")
                    }
                    NavigationLink {
                        ImageTest()
                    } label: {
                        Text("Image")
                    }
                    NavigationLink {
                        SystemImageTest()
                    } label: {
                        Text("System Image")
                    }
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
                var array = [1, 2, 3]
                array[1...] = [6, 7, 8, 9, 10]  // Now array is [6, 7, 8, 9, 10]
                GZLogFunc(array)
                let a = [Int](1..<100)
                GZLogFunc(a)
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
