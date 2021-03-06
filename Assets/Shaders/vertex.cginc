﻿/*
    Properties {
        _Distort ("Distort", Range(0,1)) = 1
        _EdgeLength ("Edge length", Range(2,50)) = 5
    }
    SubShader {
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert tessellate:tess nolightmap nodirlightmap [alpha:fade]
        #include "vertex.cginc"

        ENDCG

        Pass {
        }
    }
*/

#pragma target 4.6
#include "Tessellation.cginc"

float _EdgeLength;

float4 tess (appdata_full v0, appdata_full v1, appdata_full v2) {
    return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
}

/* Cube-Sphere projection math by Jeija
   https://youtu.be/joFWr3JzBOI
   https://github.com/Jeija/spheretest
*/

float _Distort;
float gPlanetRadius;

float4 planet (float4 vertex) {
    float rp = max(gPlanetRadius, 10.);

    float3 pos = mul(unity_ObjectToWorld,vertex).xyz;
    float3 camPos = _WorldSpaceCameraPos;

    float3 planeDiff = float3(pos - camPos);
    float2 planeDir = normalize(planeDiff.xz);
    float2 plane = float2(planeDiff.y, sqrt(dot(planeDiff.xz, planeDiff.xz)));
    float2 planeDiv = plane / rp;
    float2 planeExp = exp(planeDiv.x) * float2(cos(planeDiv.y), sin(planeDiv.y));
	float2 circle = rp * planeExp - float2(rp, 0);

    pos.x = circle.y * planeDir.x + camPos.x;
	pos.z = circle.y * planeDir.y + camPos.z;
	pos.y = circle.x + camPos.y;

    return mul(unity_WorldToObject, float4(pos, 1.));
}

void vert (inout appdata_full v) {
    v.vertex = lerp(v.vertex, planet(v.vertex), _Distort);
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
