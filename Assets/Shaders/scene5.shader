Shader "Custom/scene5" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_RimColor("Rim Color",color) = (0.0,0.0,0.0)
		_RimWidth("Rim Width",Range(0.5,8.0)) = 3.0
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float3 viewDir;
		};

		float4 _RimColor;
		float _RimWidth;

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutputStandard o) {
			o.Albedo = _Color;
			half rim = 1.0 - saturate(dot(normalize(IN.viewDir),o.Normal));
			half rim2 = pow(rim,_RimWidth);
			half rim3;
			if (rim2 < 0.5) rim3 = 1.0;
			else rim3 = 0.0;
			o.Albedo *= rim3;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
