Shader "Custom/Text Tesselation"
{
	Properties
	{
        _MainTex ("Font Texture", 2D) = "white" {}
		_Color ("Text Color", Color) = (1,1,1,1)
        _Distort ("Distort", Range(0,1)) = 1
        _EdgeLength ("Edge length", Range(2,50)) = 5
	}
	SubShader
	{
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
        Lighting Off Cull Off ZWrite Off Fog { Mode Off }
		Blend SrcAlpha OneMinusSrcAlpha
		LOD 100

		CGPROGRAM
		#pragma surface surf Lambert alpha:fade tessellate:tess vertex:vert nolightmap nodirlightmap
        #include "vertex.cginc"

		struct Input {
			float4 color : COLOR;
			float2 uv_MainTex : TEXCOORD0;
		};

		sampler2D _MainTex;
		float4 _Color;

		void surf (Input input, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, input.uv_MainTex);
			o.Alpha = c.a;
			o.Albedo = _Color;
			o.Specular = 0.2;
			o.Gloss = 1.0;
		}

		ENDCG

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct v2f {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
            };

			sampler2D _MainTex;
	        fixed4 _Color;

            v2f vert (
                float4 vertex : POSITION, // vertex position input
                float2 uv : TEXCOORD0 // first texture coordinate input
                )
            {
                v2f o;
                o.pos = UnityObjectToClipPos(vertex);
                o.uv = uv;
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
				//fixed4 col = tex2D(_MainTex, i.uv);
		  		//return _Color * col.a;
				return float4(0, 0, 0, 0);
			}
            ENDCG
        }
 
	}
}
