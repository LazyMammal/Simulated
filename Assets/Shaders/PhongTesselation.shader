Shader "Custom/PhongTesselation" {
    Properties {
        _Distort ("Distort", Range(0,1)) = 1
        _PlanetRadius ("_PlanetRadius", Range(10,50000)) = 22.5
        _EdgeLength ("Edge length", Range(2,50)) = 5
        _Phong ("Phong Strengh", Range(0,1)) = 0.5
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _Color ("Color", color) = (1,1,1,0)
    }
    SubShader {
        Tags { "RenderType"="Opaque" }
        LOD 300
        
        CGPROGRAM
        #pragma surface surf Lambert addshadow fullforwardshadows vertex:vert tessellate:tess tessphong:_Phong nolightmap
        #include "vertex.cginc"

        float _Phong;

        struct Input {
            float2 uv_MainTex;
        };

        fixed4 _Color;
        sampler2D _MainTex;

        void surf (Input IN, inout SurfaceOutput o) {
            half4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
