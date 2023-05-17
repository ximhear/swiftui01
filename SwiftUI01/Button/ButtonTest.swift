//
//  ButtonTest.swift
//  SwiftUI01
//
//  Created by we on 2023/05/08.
//

import SwiftUI

struct ButtonTest: View {
    var body: some View {
        VStack {
            HStack {
                Button("Click") {
                }
                Button("Click", role: .cancel) {
                }
                Button("Click", role: .destructive) {
                }
            }
            Button {
            } label: {
                Label {
                    Text("Click")
                } icon: {
                    Image(systemName: "chart.bar.fill")
                }
                Label.init("title", systemImage: "chart.bar.fill")
                    .labelStyle(RedBorderedLabelStyle())
            }
            HStack {
                Button {
                } label: {
                    Label {
                        Text("Click")
                    } icon: {
                        Image(systemName: "chart.bar.fill")
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 4))
                }
                Button {
                } label: {
                    Label {
                        Text("Click")
                    } icon: {
                        Image(systemName: "chart.bar.fill")
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16, style: .circular).stroke(lineWidth: 1))
                }
            }
            HStack {
                Button {
                } label: {
                    HStack {
                        Text("CLICK")
                            .font(.title)
                    }
                }
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .buttonStyle(.bordered)
                Button {
                } label: {
                    HStack {
                        Text("CLICK")
                            .font(.title)
                    }
                }
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .buttonStyle(BorderedProminentButtonStyle())
                .shadow(color: .red, radius: 8, x: 10, y: 10)
            }
            HStack {
                Button {
                } label: {
                    Text("Hello")
                        .font(.title)
                        .padding()
                }
                .buttonStyle(CircleButtonStyle())
                CustomButton {
                    GZLogFunc()
                } content: {
                    Text("CLICK")
                        .font(.title)
                }

            }
            .padding()
        }
    }
}

struct CircleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.red : Color.green)
            .clipShape(Circle())
            .overlay(Circle().stroke(lineWidth: 14).foregroundColor(configuration.isPressed ? Color.green.opacity(0.5) : Color.red.opacity(0.5)))
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .scaleEffect(x: configuration.isPressed ? -1.0 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

struct RedBorderedLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        Label(configuration)
            .padding()
            .border(.red)
    }
}


struct ButtonTest_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTest()
    }
}
