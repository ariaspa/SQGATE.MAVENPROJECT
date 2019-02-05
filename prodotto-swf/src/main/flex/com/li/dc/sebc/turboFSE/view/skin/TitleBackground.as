package com.li.dc.sebc.turboFSE.view.skin
{
	import flash.display.Graphics;
	import flash.geom.Matrix;
	 
	
	import mx.skins.halo.TitleBackground;
	import mx.styles.StyleManager;
	import mx.utils.ColorUtil;

	public class TitleBackground extends mx.skins.halo.TitleBackground
	{
		public function TitleBackground()
		{
			super();
		}
		/**
		 *  @private
		 */
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			//super.updateDisplayList(w, h);
	
			var borderAlpha:Number = getStyle("borderAlpha");
			var cornerRadius:Number = getStyle("cornerRadius");
			var highlightAlphas:Array = getStyle("highlightAlphas");
			var headerColors:Array = getStyle("headerColors");
			var showChrome:Boolean = headerColors != null;
	        StyleManager.getColorNames(headerColors);
			
			var colorDark:Number = ColorUtil.adjustBrightness2(
				headerColors ? headerColors[1] : 0xFFFFFF, -20);
					
			var g:Graphics = graphics;
			 
			g.clear();
			
			if (h < 3)
				return;
			 
			// Only draw the background if headerColors are defined.
			if (showChrome) 
			{
				g.lineStyle(0, colorDark, borderAlpha);
				g.moveTo(0, h);
				g.lineTo(w, h);
				g.lineStyle(0, 0, 0); 
		 		//////////////////////////////////////////////////////////////
				var col1:uint 				= headerColors[0];
				var col2:uint 				= headerColors[1];
				var colHsb:uint				= ColorUtil.adjustBrightness(col2,100);
				var h3:Number	= h/3;
				//  fondo
				drawRoundRect(
					0, 0, w, h,
					{ tl: cornerRadius, tr: cornerRadius, bl: 0, br: 0 },
					[colHsb,col2], [1,1],rotatedGradientMatrix(0,  0, w, h ,0));
				//
				// bordi top bottom	
				var colors:Array 	= [0xFFFFFF,0xFFFFFF,0x0,0x0];
				var step:Number		= 254/8;
				var alphas:Array	= [0.5,0,0,0.5];	
				var gRatios:Array 	= [0,uint(step),254-uint(step),254];
				var gMatrix:Matrix	= rotatedGradientMatrix(0, 0, w, h,90);
				g.beginGradientFill("linear", colors, alphas, gRatios, gMatrix);	
				g.drawRoundRectComplex(0,0,w,h,	cornerRadius,cornerRadius,0,0);
				g.endFill();	
				//	
				colors				= [col2,0];
				alphas				= [0,0.5];
				gRatios				= [0,0xFF];
				var cr:uint			= cornerRadius*2;
				gMatrix				= rotatedGradientMatrix(w-5, 0, 5, h,0);
				g.beginGradientFill("linear", colors, alphas, gRatios, gMatrix);	
				g.drawRoundRectComplex(w-cr, 0, cr, h,0,cornerRadius,0,0);
				g.endFill();
				//
				colors				= [0xFFFFFF,colHsb];
				alphas				= [0.7,0];
				 
				gMatrix				= rotatedGradientMatrix(0, 0, 5, h,0);
				g.beginGradientFill("linear", colors, alphas, gRatios, gMatrix);	
				g.drawRoundRectComplex(0, 0, cr, h,cornerRadius,0,0,0);
				g.endFill();
				///////////////////////////////////////////////////////////////
			}
		}
	}
}