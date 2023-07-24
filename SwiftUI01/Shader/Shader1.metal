//
//  Shader1.metal
//  SwiftUI01
//
//  Created by gzonelee on 2023/07/24.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] half4
colorEffect(float2 position, half4 color) {
    return half4(color.g, color.b, color.r, color.a);
}

[[ stitchable ]] float2
distortEffect(float2 position, float2 col1, float2 col2) {
    float2 newPos = float2x2(col1, col2) * position;
    return newPos;
}

[[ stitchable ]] half4
layerEffect(float2 position, SwiftUI::Layer layer, float x, float y) {
    float2 newPos = position;
    if (newPos.x > 100 || newPos.y > 100) {
        newPos = float2(x, y);
    }
    return layer.sample(newPos);
}
