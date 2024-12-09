Shader "Custom/NormalMapWithRoughnessHeightOcclusionMetallic"
{
    Properties
    {
        _MainTex ("Base Texture", 2D) = "white" { }
        _NormalMap ("Normal Map", 2D) = "bump" { }
        _HeightMap ("Height Map", 2D) = "black" { }
        _OcclusionMap ("Occlusion Map", 2D) = "black" { }
        _Color ("Base Color", Color) = (1, 1, 1, 1)
        _Bumpiness ("Bumpiness", Range(0, 1)) = 1.0
        _Roughness ("Roughness", Range(0, 1)) = 0.5
        _HeightScale ("Height Scale", Range(0, 1)) = 0.1
        _Metallic ("Metallic", Range(0, 1)) = 0.0
    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            // Shader properties
            sampler2D _MainTex;
            sampler2D _NormalMap;
            sampler2D _HeightMap;
            sampler2D _OcclusionMap;
            float4 _Color;
            float _Bumpiness;
            float _Roughness;
            float _HeightScale;
            float _Metallic;

            // Vertex structure
            struct appdata_t
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : POSITION;
                float2 uv : TEXCOORD0;
            };

            // Vertex shader
            v2f vert(appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            // Fragment shader
            half4 frag(v2f i) : SV_Target
            {
                // Sample the base texture (diffuse texture)
                half4 baseColor = tex2D(_MainTex, i.uv) * _Color;

                // Sample the normal map and apply the bumpiness factor
                half3 normalMap = tex2D(_NormalMap, i.uv).rgb;
                normalMap = normalMap * 2.0 - 1.0;  // Convert from [0,1] to [-1,1]
                normalMap *= _Bumpiness;

                // Sample the height map (displacement map) for surface details
                float height = tex2D(_HeightMap, i.uv).r;
                height = (height * 2.0 - 1.0) * _HeightScale; // Convert to [-1,1] and scale it

                // Apply height to the object's vertex displacement (could be done in the vertex shader for more performance)
                normalMap += height;

                // Sample the occlusion map (Ambient Occlusion)
                float occlusion = tex2D(_OcclusionMap, i.uv).r; // Occlusion is typically a grayscale texture

                // Light direction (simple fixed directional light for demonstration)
                half3 lightDir = normalize(float3(0.5, 1.0, 0.5)); // Directional light

                // Normalize the normal from the normal map
                half3 normal = normalize(normalMap);

                // Diffuse lighting calculation (Lambertian reflection)
                float diff = max(0.0, dot(normal, lightDir));

                // Apply roughness (higher roughness = less specular reflection)
                float specular = pow(max(0.0, dot(normal, lightDir)), 1.0 / (_Roughness + 0.1));  // Basic specular model

                // Apply metallic property
                // Metalness affects the specular reflection. If metallic is 1, the surface is fully metallic
                float specularColor = lerp(0.04, 1.0, _Metallic); // Non-metallic surfaces have a base specular value of 0.04

                // Final color combining diffuse, occlusion, specular components, and metallic adjustment
                half4 finalColor = baseColor * diff * occlusion + specularColor * specular * _Color;

                return finalColor;
            }
            ENDCG
        }
    }

    Fallback "Diffuse"
}
