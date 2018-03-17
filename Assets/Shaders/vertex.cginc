/*
    Properties {

        _EdgeLength ("Edge length", Range(2,50)) = 15

    }
    SubShader {
        CGPROGRAM

        #pragma surface vertex:vert tessellate:tess
        #include "vertex.cginc"

        ENDCG
    }
*/

#pragma target 4.6
#include "Tessellation.cginc"

struct appdata {
    float4 vertex : POSITION;
    float4 tangent : TANGENT;
    float3 normal : NORMAL;
    float2 texcoord : TEXCOORD0;
};

float _EdgeLength;

float4 tess (appdata v0, appdata v1, appdata v2)
{
    return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
}

void vert (inout appdata v) {
    float3 worldPos = mul(unity_ObjectToWorld,v.vertex).xyz;
    worldPos.x += sin(_Time[2]);
    v.vertex = mul(unity_WorldToObject,float4(worldPos, 1.));
}

/*

float3 worldPos = mul(unity_ObjectToWorld,v).xyz;

float4 clipPos = UnityObjectToClipPos(pos);   // mul(UNITY_MATRIX_MVP, float4(pos, 1.0))         transform point from object space to the camera’s clip space
float3 viewPos = UnityObjectToViewPos(pos);   // mul(UNITY_MATRIX_MV,  float4(pos, 1.0)).xyz     transform point from object space to view space

UNITY_MATRIX_MVP        float4x4    Current model * view * projection matrix.
UNITY_MATRIX_MV         float4x4    Current model * view matrix.
UNITY_MATRIX_V          float4x4    Current view matrix.
UNITY_MATRIX_P          float4x4    Current projection matrix.
UNITY_MATRIX_VP         float4x4    Current view * projection matrix.
UNITY_MATRIX_T_MV       float4x4    Transpose of model * view matrix.
UNITY_MATRIX_IT_MV      float4x4    Inverse transpose of model * view matrix.
unity_ObjectToWorld     float4x4    Current model matrix.
unity_WorldToObject     float4x4    Inverse of current world matrix.

unity_CameraProjection          float4x4    Camera’s projection matrix.
unity_CameraInvProjection       float4x4    Inverse of camera’s projection matrix.
unity_CameraWorldClipPlanes[6]  float4      Camera frustum plane world space equations, in this order: left, right, bottom, top, near, far.
_WorldSpaceCameraPos            float3      World space position of the camera.

_Time       float4    Time since level load (t/20, t, t*2, t*3), use to animate things inside the shaders.
_SinTime    float4    Sine of time: (t/8, t/4, t/2, t).
_CosTime    float4    Cosine of time: (t/8, t/4, t/2, t).

*/
