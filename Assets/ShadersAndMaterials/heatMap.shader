Shader "Custom/heatMap"
{
    Properties
    {
        _HeatMapTex ("Heat Map Texture", 2D) = "white" {}
        _MaxIntensity ("Max Intensity", Float) = 1.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata_t
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _HeatMapTex;
            float _MaxIntensity;

            v2f vert (appdata_t v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // Fetch the heat map texture color
                fixed4 heatColor = tex2D(_HeatMapTex, i.uv);

                // Normalize intensity (assuming intensity is in the red channel)
                float intensity = heatColor.r / _MaxIntensity;

                // Generate a final color based on intensity
                fixed4 finalColor = fixed4(intensity, 0.0, 1.0 - intensity, 1.0);
                return finalColor;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
