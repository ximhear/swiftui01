//
//  AnySomeTest.swift
//  SwiftUI01
//
//  Created by we on 2023/05/25.
//

import SwiftUI

protocol AuthorProtocol {
    var name: String { get }
}

protocol Language {
    var name: String { get }
//    associatedtype AUTHOR: AuthorProtocol
    func hasCompiler() -> Bool
    mutating func setAuthor(author: AuthorProtocol)
    func getAuthor() -> AuthorProtocol
}

protocol Language1 {
    var name: String { get }
    associatedtype AUTHOR: AuthorProtocol
    mutating func setAuthor(author: AUTHOR)
    func getAuthor() -> AUTHOR
}

extension Language1 where AUTHOR == CppAuthor  {
    func say() {
        print("C++ is great!")
    }
}

struct Cpp1: Language1 {
    var name = "C++"
    var author: CppAuthor?
    mutating func setAuthor(author: CppAuthor) {
        self.author = author
    }
    func getAuthor() -> CppAuthor {
        return author!
    }
}
struct Python1: Language1 {
    var name = "Python"
    var author: PythonAuthor?
    mutating func setAuthor(author: PythonAuthor) {
        self.author = author
    }
    func getAuthor() -> PythonAuthor {
        return author!
    }
}

struct CppAuthor: AuthorProtocol {
    var name: String {
        "Bjarne Stroustrup"
    }
}

struct Cpp: Language {
    var name = "C++"
    func hasCompiler() -> Bool {
        return true
    }
    var author: AuthorProtocol?
    mutating func setAuthor(author: AuthorProtocol) {
        self.author = author
    }
    func getAuthor() -> AuthorProtocol {
        return author!
    }
}

struct RustAuthor: AuthorProtocol {
    var name: String {
        "Graydon Hoare"
    }
}

struct Rust: Language {
    var name = "Rust"
    func hasCompiler() -> Bool {
        return true
    }
    var author: AuthorProtocol?
    mutating func setAuthor(author: AuthorProtocol) {
        self.author = author
    }
    func getAuthor() -> AuthorProtocol {
        return author!
    }
}

struct CAuthor: AuthorProtocol {
    var name: String {
        "Dennis Ritchie"
    }
}

struct C: Language {
    var name = "C"
    func hasCompiler() -> Bool {
        return true
    }
    var author: AuthorProtocol?
    mutating func setAuthor(author: AuthorProtocol) {
        self.author = author
    }
    func getAuthor() -> AuthorProtocol {
        return author!
    }
}

struct PythonAuthor: AuthorProtocol {
    var name: String {
        "Guido van Rossum"
    }
}

struct Python: Language {
    var name = "Python"
    func hasCompiler() -> Bool {
        return false
    }
    var author: AuthorProtocol?
    mutating func setAuthor(author: AuthorProtocol) {
        self.author = author
    }
    func getAuthor() -> AuthorProtocol {
        return author!
    }
}

struct ProtocolTest: View {
    @State var languages: [Language] = []
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(languages, id: \.name) { language in
                VStack(alignment: .leading) {
                    Text(language.name)
                        .font(.largeTitle)
                        .background(.green)
                    HStack {
                        Text("Author")
                            .font(.caption)
                        Text(language.getAuthor().name)
                    }
                    .background(.yellow)
                    Divider()
                }
                .padding()
            }
        }
        .onAppear {
            var cpp = Cpp()
            cpp.setAuthor(author: CppAuthor())
            
            var c = C()
            c.setAuthor(author: CAuthor())
            
            var rust = Rust()
            rust.setAuthor(author: RustAuthor())
            
            var python = Python()
            python.setAuthor(author: PythonAuthor())
            
            languages = [cpp, c, python, rust]
            var authors: [AuthorProtocol] = []
            for x in languages {
                authors.append(x.getAuthor())
            }
            
            var ccc = Cpp1()
            ccc.setAuthor(author: CppAuthor())
            ccc.say()
            
            var ppp = Python1()
            ppp.setAuthor(author: PythonAuthor())
        }
    }
}

struct ProtocolTest_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolTest()
    }
}
