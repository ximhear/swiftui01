//
//  AppStorageTest.swift
//  SwiftUI01
//
//  Created by we on 2023/05/08.
//

import SwiftUI

struct AppStorageTest: View {
    @AppStorage("appValue") var appValue: Int = 0
    @SceneStorage("sceneValue") var sceneValue: Int = 0
    var body: some View {
        VStack {
            Text("appValue : \(appValue)")
                .font(.title)
            Text("sceneValue : \(sceneValue)")
                .font(.title)
            Button("inc appValue") {
                appValue &+= 1
            }
            Button("inc sceneValue") {
                sceneValue &+= 1
            }
        }
    }
}

struct AppStorageTest_Previews: PreviewProvider {
    static var previews: some View {
        AppStorageTest()
    }
}
