//
//  GGGView.swift
//  SwiftUI01
//
//  Created by we on 2023/05/09.
//

import SwiftUI

struct GGGView: View {
    var body: some View {
        NavigationLink("gg") {
            BingoPlayground()
        }
    }
}

struct GGGView_Previews: PreviewProvider {
    static var previews: some View {
        GGGView()
    }
}
