//
//  UnsafeMain.swift
//  SwiftUI01
//
//  Created by we on 2023/06/05.
//

import SwiftUI

struct UnsafeMain: View {
    var body: some View {
        VStack {
            NavigationLink("UnsafePointer", destination: UnsafeTest())
            NavigationLink("UnsafeBufferPointer", destination: UnsafeBufferPointerTest())
            NavigationLink("UnsafeMutableBufferPointerTest", destination: UnsafeMutableBufferPointerTest())
            NavigationLink("UnsafeRawPointerTest", destination: UnsafeRawPointerTest())
        }
        .navigationTitle("Unsafe")
    }
}

struct UnsafeMain_Previews: PreviewProvider {
    static var previews: some View {
        UnsafeMain()
    }
}
