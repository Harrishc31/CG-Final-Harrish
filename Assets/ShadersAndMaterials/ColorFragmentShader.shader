Shader "Custom/ColorFragmentShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
            };

            v2f vert(appdata v)
            {
                v2f o;
                UNITY_INITIALIZE_OUTPUT(v2f, o)
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color.b = (v.vertex.z + 1) / 5;
                o.color.g = (v.vertex.z + 2) / 5;
                o.color.r = (v.vertex.y + 1) /5 ;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 col = i.color;
                //.b = i.vertex.y / 500;
                //col.g = i.vertex.z / 1000;
                //col.r = i.vertex.x / 500;
                return col;
            }
            ENDCG
        }
    }
}