//
//  TextTest.swift
//  SwiftUI01
//
//  Created by we on 2023/05/16.
//

import SwiftUI

struct TextTest: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("ABCDEF").kerning(-3)
                    .background(.green.opacity(0.5))
                Text("ABCDEF").tracking(-3)
                    .background(.green.opacity(0.5))
                Text("ABCDEF")
                Text("ABCDEF").kerning(3)
                Text("ABCDEF").tracking(3)
            }
            .font(.title)
            .bold()
            HStack(alignment: .top) {
                Text("Hello")
                    .baselineOffset(-10)
                    .border(Color.red)
                Text("Hello")
                    .border(Color.green)
                Text("Hello")
                    .baselineOffset(100)
                    .border(Color.blue)
            }
            .font(.title)
            .background(Color(white: 0.9))
            VStack {
                Text("START hello\nhellosdjflsdjflsjdlfjsdlflsdfsldjflsd sdjfls d lsd lsdj lsd lsdfl sldf jsldf sldfls  kls sldf lsdf lsdf lsdf lsdf lksfklsdflsdflksdflksdlfsdlfsdl s flsd ls ls slf ksldfklsdflsdf klsfkl slfslfslkflsf lsflsdjflksdjf ls fsklflsf\nsdjflsjdlfjl END")
                    .lineLimit(5)
//                    .textCase(.uppercase)
                    .truncationMode(.middle)
                    .padding()
                    .multilineTextAlignment(.center)
                    .lineSpacing(20)
                    .allowsTightening(true)
                    .minimumScaleFactor(0.5)
                
                Text(makeAttributedString())
            }
        }
    }
    
    func makeAttributedString() -> AttributedString {
        var attributedString = AttributedString("Hello, SwiftUI!\n")
        
        if let boldFont = UIFont(name: "Helvetica-Bold", size: 20) {
            attributedString.font = boldFont
            attributedString.foregroundColor = .red
//            attributedString[...] = .font(boldFont)
//            attributedString[...] = .foregroundColor(.red)
        }
        
        var secondLine = AttributedString("This is fun!\n")
        if let italicFont = UIFont(name: "Helvetica-Oblique", size: 16) {
            secondLine.font = italicFont
            secondLine.foregroundColor = .blue
//            secondLine[...] = .font(italicFont)
//            secondLine[...] = .foregroundColor(.blue)
        }
        
        attributedString.append(secondLine)
        
        var thirdLine = AttributedString("AttributedString is powerful!\n")
        if let thirdFont = UIFont(name: "Helvetica", size: 14) {
            thirdLine.font = thirdFont
            thirdLine.foregroundColor = .green
//            thirdLine[...] = .font(thirdFont)
//            thirdLine[...] = .foregroundColor(.green)
        }
        
        attributedString.append(thirdLine)
        
        return attributedString
    }
}

struct TextTest_Previews: PreviewProvider {
    static var previews: some View {
        TextTest()
    }
}
