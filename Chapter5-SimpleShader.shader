﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'
//Unity支持的语义:POSITION,TANGENT,NORMAL,TEXCOOORD0,TEXCOORD1,TEXCOORD2,TEXCOORD3,COLORD等
Shader "Unity Shaders Book/Chapter 5/Simple Shader"{
	Properties{
		//声明一个Color类型的属性
		_Color("Color Tint",Color) = (1.0,1.0,1.0,1.0)
	}
		SubShader{
			Pass{
			CGPROGRAM
	#pragma vertex vert
	#pragma fragment frag
			//在Cg代码中,我们需要定义一个与属性名称和类型都匹配的变量
			fixed4 _Color;
	struct a2v {
		//POSITION语义告诉Unity，用模型空间的顶点坐标填充vertex变量
		float4 vertex:POSITION;
		//NORMAL语义告诉Unity,用模型空间的发现方向填充normal变量
		float3 normal:NORMAL;
		//TEXCOORD0语义告诉Unity,用模型空间的第一套纹理坐标填充texcoord变量
		float4 texcoord : TEXCOORD0;
	};
	struct v2f {
		//SV_POSITION语义告诉Unity,pos里包含了顶点在裁剪空间中的位置信息
		float4 pos:SV_POSITION;
		//COLOR语义可以用于存储颜色信息
		fixed3 color : COLOR;
	};
	v2f vert(a2v v){
		//声明输出结构
		v2f o;
		o.pos = UnityObjectToClipPos(v.vertex);
		//v.normal包含了顶点的法线方向，其分量范围在[-1.0,1.0]
		//下面的代码把分量范围映射到了[0.0,1.0]
		//存储到o.color中传递给片元着色器
		o.color = v.normal*0.5 + fixed3(0.5, 0.5, 0.5);
		return o;
	}
	fixed4 frag(v2f i) : SV_Target{
		fixed3 c = i.color;
		c *= _Color.rgb;
		return fixed4(c,1.0);
	}
	ENDCG
	}
	}
}