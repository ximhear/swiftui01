//
//  ProtocolGenerics.swift
//  SwiftUI01
//
//  Created by we on 2023/05/25.
//

import SwiftUI

protocol AAA {
    var value: Int { get set }
}

struct Hello {
    
}

struct Greet<A, B> {
    let a: A
    let b: B
}

protocol AA {
    // associatedtype을 TTT: XXX 형식으로 할 경우, XXX는 class나 protocol이어야 한다.
    // where Self.TTT == XXX로 할 경우, XXX는 명확해야 한다.
    
    // Hello는 struct로 명확하다.
    associatedtype TTT where Self.TTT == Hello
    var value: Self.TTT { get }
    
    // Identifiable에는 ID라는 associatedtype이 있다. 이것이 명확하지 않아서 오류.
//    associatedtype AAA where Self.AAA == Identifiable
    
    // AAA는 protocol이지만, associatedtype이 없어서 명확하다.
    associatedtype BBB where Self.BBB == AAA
    
    // Greet는 Generics여서 명확하지 않다.
//    associatedtype CCC where Self.CCC == Greet
    
    // Greet에 Generics param를 모두 제공하면 명확해진다.
    associatedtype DDD where Self.DDD == Greet<Int, Float>
    
    // CustomViewProtocol은 protocol이고 명확하지 않으므로 아래와 같이 해야한다.
    associatedtype EEE: CustomViewProtocol
    // AnyCustomView은 명확하다.
    associatedtype FFF where Self.FFF == AnyCustomView
}

// ID 타입을 지정해줄 때는 타입 정의에 where로 붙여주거나 associatedtype + where로 할 수 있다.
// 둘 중 하나만 사용하면 된다.
protocol CustomViewProtocol: Identifiable where ID == UUID {
//    associatedtype ID where Self.ID == UUID
    associatedtype Title: View
    @ViewBuilder var title: Self.Title { get }
}

struct AnyCustomView: CustomViewProtocol {
    typealias Title = AnyView
    let id: UUID
    
    private let _title: () -> AnyView

    init<Base: CustomViewProtocol>(_ base: Base) where Base.Title: View {
        self.id = base.id
        self._title = { AnyView(base.title) }
    }

    var title: AnyView {
        self._title()
    }
}

// Usage
struct CustomView1: CustomViewProtocol {
    let id: UUID = UUID()
    var title: some View {
        Label("Custom View 1", systemImage: "chart.bar.fill")
    }
}

struct CustomView2: CustomViewProtocol {
    let id: UUID = UUID()
    var title: some View {
        Text("Custom View 2")
    }
}


struct ProtocolGenerics: View {
    let array: [AnyCustomView] = [AnyCustomView(CustomView1()), AnyCustomView(CustomView2())]
    var body: some View {
        VStack {
            List {
                ForEach(array) { item in
                    item.title
                }
            }
        }
        .onAppear {
        }
    }
}

struct ProtocolGenerics_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolGenerics()
    }
}
