Shader "Custom/RimLight"
{
    Properties
    {
        _RimColor ("Rim Color", Color) = (0, 0.5, 0.5, 0.0)
        _RimPower ("Rim Power", Range(0.5, 8.0)) = 3.0
        
        //toon shader properties
        _Color ("Main Color", Color) = (1, 1, 1, 1)
        _Ramp ("Ramp Texture", 2D) = "white" { }
        _ShadingStep ("Shading Step", Range(1, 10)) = 4

    }
    SubShader
    {
       
        Pass // pass allows to combine two effects at once.
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            sampler2D _Ramp;
            float _ShadingStep;
            float4 _Color;


            struct appdata_t
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : POSITION;
                float3 normal : NORMAL;
            };

            // function for the vertex shader 
            v2f vert(appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normal = normalize(v.normal);
                return o;
            }

            // frag shader (the part that does the toon shading)
            half4 frag(v2f i) : SV_Target
            {
                // light on the normalized surface
                float3 lightDir = normalize(float3(0.5, 1.0, 0.5)); // Light direction (arbitrary)

                // Calculate the dot product of the directional light and surface normals
                float diff = max(0, dot(i.normal, lightDir));

                // applies the diffuse light with the shading steps (the part that controlls to intensity of the shadows)
                diff = floor(diff * _ShadingStep) / _ShadingStep;

                // Gets the toon ramp texture
                half4 rampColor = tex2D(_Ramp, float2(diff, 0)); // Sampling the ramp texture

                // returns final toon texture
                return rampColor * _Color;
            }
            ENDCG
        }
    }
    Fallback "Diffuse"
}