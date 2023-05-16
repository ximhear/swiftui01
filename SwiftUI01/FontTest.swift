//
//  FontTest.swift
//  SwiftUI01
//
//  Created by we on 2023/05/16.
//

import SwiftUI

struct FontTest: View {
    var body: some View {
        HStack {
            VStack {
                Group {
                    Text("largeTitle").font(.largeTitle)
                    Text("title").font(.title)
                    Text("title2").font(.title2)
                    Text("title3").font(.title3)
                    Text("headline").font(.headline)
                    Text("subheadline").font(.subheadline)
                }
                Group {
                    Text("body").font(.body)
                    Text("callout").font(.callout)
                    Text("footnote").font(.footnote)
                    Text("caption").font(.caption)
                    Text("caption2").font(.caption2)
                }
                Group {
                    Text("custom").font(.system(size: 30, weight: .heavy, design: .default))
                    Text("custom").font(.system(size: 30, weight: .heavy, design: .rounded))
                    Text("custom").font(.system(size: 30, weight: .heavy, design: .monospaced))
                }
                Group {
                    Text("custom").font(.system(size: 30, weight: .ultraLight))
                    Text("custom").font(.system(size: 30, weight: .thin))
                    Text("custom").font(.system(size: 30, weight: .light))
                    Text("custom").font(.system(size: 30, weight: .regular))
                    Text("custom").font(.system(size: 30, weight: .medium))
                    Text("custom").font(.system(size: 30, weight: .semibold))
                    Text("custom").font(.system(size: 30, weight: .bold))
                    Text("custom").font(.system(size: 30, weight: .heavy))
                    Text("custom").font(.system(size: 30, weight: .black))
                }
                Group {
                    Text("1234567890")
                        .font(.title)
                        .foregroundColor(.green)
                        .bold()
                        .italic()
                        .monospacedDigit()
                        .strikethrough(pattern: .dot, color: .red)
                        .underline(pattern: .dashDotDot, color: .blue)
                }
            }
        }
    }
}

struct FontTest_Previews: PreviewProvider {
    static var previews: some View {
        FontTest()
    }
}
