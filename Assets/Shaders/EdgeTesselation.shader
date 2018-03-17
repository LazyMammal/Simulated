﻿Shader "Custom/EdgeTesselation" {
    Properties {
        _Distort ("Distort", Range(0,1)) = 1
        _PlanetRadius ("_PlanetRadius", Range(10,50000)) = 22.5
        _EdgeLength ("Edge length", Range(2,50)) = 5
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _NormalMap ("Normalmap", 2D) = "bump" {}
        _Color ("Color", color) = (1,1,1,0)
        _SpecColor ("Spec color", color) = (0.5,0.5,0.5,0.5)
    }
    SubShader {
        Tags { "RenderType"="Opaque" }
        LOD 300
        
        CGPROGRAM
        #pragma surface surf BlinnPhong addshadow fullforwardshadows vertex:vert tessellate:tess nolightmap
        #include "vertex.cginc"

        struct Input {
            float2 uv_MainTex;
        };

        sampler2D _MainTex;
        sampler2D _NormalMap;
        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutput o) {
            half4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Specular = 0.2;
            o.Gloss = 1.0;
            o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_MainTex));
        }
        ENDCG
    }
    FallBack "Diffuse"
}
