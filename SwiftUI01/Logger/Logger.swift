//
//  Logger.swift
//  SwiftUI01
//
//  Created by we on 2023/06/12.
//

import Foundation

class Logger: ObservableObject {
    @Published var logs: [String] = []

    func clearLogs() {
        logs.removeAll()
    }

    func notNilObj(_ obj: Any?) -> Any {
        if let a: Any = obj {
            return a
        }
        return "nil"
    }
    
    func addLog(_ message: @autoclosure () -> Any? = "", lineNumber: Int = #line) {
        print("\(lineNumber) : \(notNilObj(message()))")
        logs.append("\(lineNumber) : \(notNilObj(message()))")
    }
}
