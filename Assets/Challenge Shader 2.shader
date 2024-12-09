Shader "Custom/Challenge Shader 2"
{
    Properties {
        _myColor ("Example Color", Color) = (1,1,1,1)
        _myRange ("Example Range", Range(0,5)) = 1
        _myTex ("Example Texture", 2D) = "white" {}
        _myTex2 ("Example Texture2", 2D) = "gray" {}
        _myCube ("Example Cube", CUBE) = "" {}
        //_myFloat ("Example Float", Float) = 0.5
        //_myVector ("Example Vector", Vector) = (0.5,1,1,1)
    }

    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _myColor;
        half _myRange;
        sampler2D _myTex;
        sampler2D _myTex2;
        samplerCUBE _myCube;
        //float _myFloat;
        //float4 _myVector;

        struct Input {
            float2 uv_myTex;
            float2 uv2_myTex;
            float3 worldRefl;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {

            o.Albedo = _myColor.rgb;
            o.Albedo.g = (tex2D(_myTex, IN.uv_myTex)).g;
            o.Emission = texCUBE (_myCube, IN.worldRefl).rgb;
          }
      
      ENDCG
    }
    
    FallBack "Diffuse"
}
