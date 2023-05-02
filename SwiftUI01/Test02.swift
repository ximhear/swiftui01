//
//  Test02.swift
//  SwiftUI01
//
//  Created by gzonelee on 2023/04/30.
//

import SwiftUI

struct Test02: View {
    @ObservedObject var navigationManager = NavigationManager()
    @ObservedObject var vm: ViewModel
    @Environment(\.scenePhase) private var scenePhase
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            VStack {
                VStack {
                    Text("\(vm.value)")
                }
                Button("Btn 01") {
                    vm.inc()
                    navigationManager.add("button 01")
                }
                Button("Btn 02") {
                    vm.inc()
                    navigationManager.add("button 02")
                }
                Button("Btn 03") {
                    vm.inc()
                    navigationManager.add("button 03")
                }
                Button("Btn 04") {
                    vm.inc()
                    navigationManager.add("button 04")
                }
            }
            .navigationDestination(for: String.self) { value in
                Text(value)
            }
        }
        .onChange(of: scenePhase) { phase in
            GZLogFunc(phase)
        }
    }
}

struct Test02_Previews: PreviewProvider {
    @ObservedObject static var vm = ViewModel(value: 100)
    static var previews: some View {
        Test02(vm: vm)
    }
}
