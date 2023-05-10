//
//  GGGViewModel.swift
//  SwiftUI01
//
//  Created by we on 2023/05/10.
//

import Foundation
import Combine

class GGGViewModel: ObservableObject {
    
    @Published var value: Int = 0
    var cancellable: AnyCancellable?
    
    func run() {
        let s1 = PassthroughSubject<Int, Never>.init()
        let s2 = PassthroughSubject<Int, Never>.init()
        let s3 = PassthroughSubject<Int, Never>.init()
        cancellable = s1.zip(s2)
            .zip(s3)
            .sink(receiveValue: { v in
                GZLogFunc(v)
            })
        s1.send(1)
        s1.send(2)
        s1.send(3)
        s1.send(4)
        
        s2.send(10)
        s2.send(20)
        s2.send(30)
        
        s3.send(100)
        s3.send(200)
        
    }
}
