//
//  ModalTest.swift
//  SwiftUI01
//
//  Created by gzonelee on 2023/06/01.
//

import SwiftUI

struct ModalData: Identifiable {
    let id = UUID()
    let text: String
}

struct ModalTest: View {
    @State var isPresented1 = false
    @State var modalData2: ModalData?
    @State var isPresented3 = false
    @State var modalData4: ModalData?
    @State var isPresented5 = false
    @State var modalData6: ModalData?
    @State var isPresented7 = false
    @State var strings = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
    ]
    
    var body: some View {
        VStack {
            Group {
                Button("click1") {
                    isPresented1 = true
                }
                Button("click2") {
                    modalData2 = ModalData(text: "2")
                }
                Button("click3") {
                    isPresented3 = true
                }
                Button("click4") {
                    modalData4 = ModalData(text: "4")
                }
                Button("click5") {
                    isPresented5 = true
                }
                .popover(isPresented: $isPresented5,
                         arrowEdge: .top
                ) {
                    VStack {
                        Text("5")
                    }
                    .padding(32)
                    .background(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                Button("click6") {
                    modalData6 = ModalData(text: "6")
                }
                .popover(item: $modalData6) { data in
                    VStack {
                        Text(data.text)
                    }
                }
                Button("click7") {
                    GZLogFunc()
                    isPresented7 = true
                }
            }
            .padding(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.yellow)
        .modifier(ModalViewModifier(isPresented: $isPresented7, title: {
            Text("Title")
        }, body: {
            Text("Body")
        }, buttons: {
            Button("Close") {
                isPresented7 = false
            }
        }))
        .sheet(isPresented: $isPresented1, onDismiss: {
            GZLogFunc()
        }) {
            VStack {
                ScrollView {
                    VStack {
                        ForEach(strings, id: \.self) { v in
                            Text(v).padding()
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                }
                Button("Close") {
                    isPresented1 = false
                }
            }
            .presentationDetents([.medium, .large])
//            .presentationContentInteraction(.scrolls)
            .presentationContentInteraction(.resizes)
            .presentationDragIndicator(.visible)
            .presentationBackground(.ultraThinMaterial)
            .presentationBackgroundInteraction(.disabled)
//            .presentationBackground {
//                VStack {
//                    Image(systemName: "globe")
//                        .resizable()
//                        .scaledToFit()
//                        .foregroundColor(.red.opacity(0.2))
//                }
//                .background(.thinMaterial)
//            }
            .presentationCornerRadius(64)
        }
        .sheet(item: $modalData2) {
            GZLogFunc()
        } content: { data in
            VStack {
                Text(data.text)
                    .font(.largeTitle)
                Button("close2") {
                    modalData2 = nil
                }
            }
        }
        .fullScreenCover(isPresented: $isPresented3, onDismiss: {
            GZLogFunc()
        }) {
            VStack {
                Text("3")
                Button("Close") {
                    isPresented3 = false
                }
            }
        }
        .fullScreenCover(item: $modalData4) {
            GZLogFunc()
        } content: { data in
            VStack {
                Text(data.text)
                    .font(.largeTitle)
                Button("close4") {
                    modalData4 = nil
                }
            }
        }
    }
}

struct ModalTest_Previews: PreviewProvider {
    static var previews: some View {
        ModalTest()
    }
}


struct ModalViewModifier<Title: View, Body: View, Buttons: View>: ViewModifier {
    @Binding var isPresented: Bool
    let title: Title
    let body: Body
    let buttons: Buttons
    
    init(isPresented: Binding<Bool>, @ViewBuilder title: () -> Title, @ViewBuilder body: () -> Body, @ViewBuilder buttons: () -> Buttons) {
        self._isPresented = isPresented
        self.title = title()
        self.body = body()
        self.buttons = buttons()
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isPresented = false
                    }
                
                VStack {
                    title
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                    
                    body
                    
                    buttons
                        .padding()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
        }
    }
}
