//
//  Test02.swift
//  SwiftUI01
//
//  Created by gzonelee on 2023/04/30.
//

import SwiftUI

struct Test02: View {
    @ObservedObject var navigationManager = NavigationManager()
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            VStack {
                Button("Btn 01") {
                    navigationManager.add("button 01")
                }
                Button("Btn 02") {
                    navigationManager.add("button 02")
                }
                Button("Btn 03") {
                    navigationManager.add("button 03")
                }
                Button("Btn 04") {
                    navigationManager.add("button 04")
                }
            }
            .navigationDestination(for: String.self) { value in
                Text(value)
            }
        }
    }
}

struct Test02_Previews: PreviewProvider {
    static var previews: some View {
        Test02()
    }
}
