package com.li.dc.sebc.turboFSE.view.skin
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.InterpolationMethod;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	
	import mx.skins.Border;
	import mx.utils.ColorUtil;

	public class ResizableBoxSkin extends Border
	{
		public function ResizableBoxSkin()
		{
			super();
		}
		protected override function updateDisplayList(unscaledWidth:Number,
									     unscaledHeight:Number):void
		{
			var bckcolor:int = this.getStyle("backgroundColor") as int;
			var bckalpha:Number = this.getStyle("backgroundAlpha") as Number;
			var radius:Number = this.getStyle("cornerRadius") as Number;
			var g:Graphics = this.graphics;
			g.clear();
			//
			var type:String = GradientType.LINEAR;
			var colors:Array = [0xFFFFFF,bckcolor,ColorUtil.adjustBrightness(bckcolor,-60)];
			var alphas:Array = [1, 1 ,1];
			var ratios:Array = [0, 75,255];
			var spreadMethod:String = SpreadMethod.PAD;
			var interp:String = InterpolationMethod.LINEAR_RGB;
			var focalPtRatio:Number = 0;
			
			var matrix:Matrix = new Matrix();
			var boxWidth:Number = 50;
			var boxHeight:Number = 30;
			var boxRotation:Number = Math.PI/2; // 90˚
			var tx:Number = 25;
			var ty:Number = 0;
			
			matrix.createGradientBox(boxWidth, boxHeight , boxRotation, tx, ty);
			g.beginGradientFill(type, colors, alphas, ratios, matrix, spreadMethod, interp, focalPtRatio);
			g.drawRoundRectComplex(0,0,unscaledWidth,unscaledHeight,radius,radius,0,0);
			g.endFill();
			g.lineStyle(0.5,ColorUtil.adjustBrightness(bckcolor,-90),1);
			g.drawRoundRectComplex(0,0,unscaledWidth,unscaledHeight,radius,radius,0,0);
			g.endFill();
		}
	}
}