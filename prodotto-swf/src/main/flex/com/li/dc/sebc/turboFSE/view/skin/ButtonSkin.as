package com.li.dc.sebc.turboFSE.view.skin
{
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	
	import mx.skins.halo.ButtonSkin;
	import mx.utils.GraphicsUtil;

	public class ButtonSkin extends mx.skins.halo.ButtonSkin
	{
		public function ButtonSkin()
		{
			super();
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			var corner:int 			= getStyle("cornerRadius");   
			var bckAlpha:int 		= getStyle("backgroundAlpha");
			var fColor:Array		= getStyle("fillColors");
			var fAlpha:Array 		= getStyle("fillAlphas");
			var fsColor:Array 		= getStyle("fillShadowColors");
			var fsAlpha:Array 		= getStyle("fillShadowAlphas");
			var fdColor:int 		= getStyle("fillDisabledColor");
			var fdAlpha:int 		= getStyle("fillDisabledAlpha");
			graphics.clear();
			switch(name)
			{
				case "upSkin":
				case "overSkin":
				case "downSkin":
				break;
				case "disabledSkin":
					filters = [new DropShadowFilter(0,45,fdColor,fdAlpha,4,4,1,1,false,false,true),
								new DropShadowFilter(3,250,fsColor[0],fsAlpha[0]),
								new DropShadowFilter(4,45,fsColor[1],fsAlpha[1])];
								break;
			}
			
			var gradient:String 	= GradientType.LINEAR;
			var mmm:Array 			= [0,255];
			var matrix:Matrix		= new Matrix();
			var spread:String	= SpreadMethod.PAD;
			matrix.createGradientBox(unscaledWidth,unscaledHeight,0,0,0);
			graphics.beginGradientFill(gradient,fColor,fAlpha,mmm,matrix,spread);
			GraphicsUtil.drawRoundRectComplex(graphics,0,0,unscaledWidth,unscaledHeight,corner,corner,corner,corner);
			graphics.endFill();
			
			if(name != "downSkin" && name!="disabledSkin")
			{
			
				filters = [new DropShadowFilter(3,250,fsColor[0],fsAlpha[0]),new DropShadowFilter(4,45,fsColor[1],fsAlpha[1])];
			}
			 
		}
	}
}