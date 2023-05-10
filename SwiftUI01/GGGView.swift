//
//  GGGView.swift
//  SwiftUI01
//
//  Created by we on 2023/05/09.
//

import SwiftUI

struct GGGView: View {
   @ObservedObject var vm = GGGViewModel()
    var body: some View {
        VStack {
            NavigationLink("gg") {
                BingoPlayground()
            }
            .padding()
            Button("run") {
                vm.run()
            }
            .padding()
        }
    }
}

struct GGGView_Previews: PreviewProvider {
    static var previews: some View {
        GGGView()
    }
}
