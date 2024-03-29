//
//  ContentView.swift
//  SwiftUI01
//
//  Created by gzonelee on 2023/04/30.
//

import SwiftUI

struct ViewLink: Identifiable {
    let id = UUID()
    let title: AnyView
    let destination: AnyView
    
    init(title: any View, destination: any View) {
        self.title = AnyView(title)
        self.destination = AnyView(destination)
    }
    
    init(title: String, destination: any View) {
        self.title = AnyView(Text(title))
        self.destination = AnyView(destination)
    }
}

struct ContentView: View {
    @StateObject var vm = ViewModel(value: 10)
    @State var viewLinks: [ViewLink] = []
    
    init() {
        GZLogFunc()
    }
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(viewLinks) { link in
                        NavigationLink(destination: link.destination) {
                            link.title
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Main")
            }
            .onAppear {
                GZLogFunc()
                
                var array = [1, 2, 3]
                array[1...] = [6, 7, 8, 9, 10]  // Now array is [1, 6, 7, 8, 9, 10]
                GZLogFunc(array)
                let a = [Int](1..<100)
                GZLogFunc(a)
                viewLinks = [
                    ViewLink(title: Label("Shader", systemImage: "square.stack.3d.down.right"), destination: ShaderMain()),
                    ViewLink(title: Label("Gesture", systemImage: "chart.bar.fill"), destination: GestureMain()),
                    ViewLink(title: "Modal", destination: ModalTest()),
                    ViewLink(title: "Swift Standard Library", destination: SwiftStandardLibraryView()),
                    ViewLink(title: "Generics", destination: GenericsMain()),
                    ViewLink(title: "ScrollView", destination: ScrollViewTest()),
                    ViewLink(title: "Font", destination: FontTest()),
                    ViewLink(title: "UnsafeMutableBufferPointer", destination: UnsafeMain()),
                    ViewLink(title: "Bingo", destination: GGGView()),
                    ViewLink(title: "Button", destination: ButtonTest()),
                    ViewLink(title: "Async Image", destination: AsyncImageTest()),
                    ViewLink(title: "Image", destination: ImageTest()),
                    ViewLink(title: "System Image", destination: SystemImageTest()),
                    ViewLink(title: "ZStack", destination: ZStackTest()),
                    ViewLink(title: "AppStorage", destination: AppStorageTest()),
                    ViewLink(title: "NavigationStack", destination: Test02(vm: vm))
                ]
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
