//
//  SwiftStandardLibraryView.swift
//  SwiftUI01
//
//  Created by gzonelee on 2023/06/29.
//

import SwiftUI

struct SwiftStandardLibraryView: View {
    @State var viewLinks: [ViewLink] = []
    var body: some View {
        VStack {
            List {
                ForEach(viewLinks) { link in
                    NavigationLink(destination: link.destination) {
                        link.title
                    }
                }
            }
            .listStyle(.plain)
        }
        .onAppear {
            viewLinks = [
                ViewLink(title: "Optional", destination: OptionalTest()),
                ViewLink(title: "Result", destination: ResultTest()),
                ViewLink(title: "SIMD Vector Types", destination: SimdTest()),
                ViewLink(title: "OptionSet", destination: OptionSetTest()),
                
                ViewLink(title: "Set", destination: EmptyView()),
                ViewLink(title: "Time", destination: EmptyView()),
                ViewLink(title: "Codable", destination: EmptyView()),
                ViewLink(title: "Concurrency", destination: EmptyView()),
                ViewLink(title: "Observation", destination: EmptyView()),
                
                ViewLink(title: "Range", destination: EmptyView()),
                ViewLink(title: "ClosedRange", destination: EmptyView()),
                ViewLink(title: "Error", destination: EmptyView()),
                ViewLink(title: "Regex", destination: EmptyView()),
                ViewLink(title: "StaticString", destination: EmptyView()),
                ViewLink(title: "Input and Output", destination: EmptyView()),
                ViewLink(title: "Debugging and Reflection", destination: EmptyView()),
                ViewLink(title: "Macros", destination: EmptyView()),
                ViewLink(title: "Key-Path Expressions", destination: EmptyView()),
                ViewLink(title: "Distributed", destination: EmptyView()),
            ]
        }
        .navigationTitle("Swift Standard Library")
    }
}

struct SwiftStandardLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftStandardLibraryView()
    }
}
