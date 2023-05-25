//
//  GenericsMain.swift
//  SwiftUI01
//
//  Created by we on 2023/05/25.
//

import SwiftUI

struct GenericsMain: View {
    var body: some View {
        VStack {
            List {
                NavigationLink("associatedtype", destination: ProtocolGenerics())
                NavigationLink("Protocol", destination: ProtocolTest())
                Text("any? some?")
            }
        }
    }
}

struct GenericsMain_Previews: PreviewProvider {
    static var previews: some View {
        GenericsMain()
    }
}
