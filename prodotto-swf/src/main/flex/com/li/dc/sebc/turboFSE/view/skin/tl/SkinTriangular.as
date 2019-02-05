package com.li.dc.sebc.turboFSE.view.skin.tl
{
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.SpreadMethod;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	
	import it.lispa.siss.sebc.flex.graphic.timeline.skin.SkinDefault;
	
	import mx.utils.ColorUtil;

	public class SkinTriangular extends SkinDefault
	{
		public function SkinTriangular()
		{
			super();
		}
		
		/* obj.borderColor 			= getStyle("borderColor");
		obj.cornerRadius  			= getStyle("cornerRadius");
		obj.fillAlphas  			= getStyle("fillAlphas");
		obj.fillColors 				= getStyle("fillColors");
		StyleManager.getColorNames(obj.fillColors);
		obj.highlightAlphas 		= getStyle("highlightAlphas");				
		obj.themeColor 				= getStyle("themeColor");
		obj.borderColorDrk1 		= UtilsColor.adjustBrightness(obj.borderColor, -50);
		obj.themeColorDrk1   		= UtilsColor.adjustBrightness(obj.themeColor, -25);	
		obj.cr 						= Math.max(0, obj.cornerRadius);
		obj.cr1 					= Math.max(0, obj.cornerRadius - 1);
		obj.cr2 					= Math.max(0, obj.cornerRadius - 2); 
		
		doc.setStyle("themeColor", theme);
  			doc.setStyle("fillColors",[0xFFFFFF,theme]);
  			doc.setStyle("fillAlphas",[0.2,0.7]);
  			doc.setStyle("cornerRadius",0);
		*/
		private function drawTri(w:Number,h:Number,colors:Array,alphas:Array,ratios:Array,rotation:Number=0):void
		{
			var type:String  		= GradientType.LINEAR;
			var spreadMethod:String = SpreadMethod.PAD;
			var interp:String 		= InterpolationMethod.LINEAR_RGB;
			var focalPtRatio:Number = 0;
			var tx:Number 			= 0;
			var ty:Number 			= 0;
			////////////////////////////////////////////////////////////////
			var matrix:Matrix 		= new Matrix();
			matrix.createGradientBox(w, h/2, rotation, tx, ty);
			graphics.beginGradientFill(type, colors,alphas,ratios, matrix, spreadMethod, interp, focalPtRatio);
			draw(w,h);	                                       
		}
		private function draw(w:Number,h:Number):void
		{
			graphics.moveTo(0,h);
			graphics.lineTo(w,h);                                        
			graphics.lineTo(w/2,0);                                        
			graphics.lineTo(0,h);
			graphics.endFill(); 
		}
		override protected function drawOverSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			drawUpSkin(unscaledWidth,unscaledHeight);
			this.filters = [new GlowFilter( getStyle("themeColor") )];
		}
		override protected function drawUpSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var rotation:Number 	= -90/180*Math.PI;
			var theme:int 		= getStyle("themeColor");
			var darkTheme:int   = ColorUtil.adjustBrightness(theme,-50);
			var lightTheme:int  = ColorUtil.adjustBrightness(theme,120);
			graphics.clear();
			//drawTri(unscaledWidth,unscaledHeight,[theme,theme],[1,1],[126,255],rotation);
			drawTri(unscaledWidth,unscaledHeight,[theme,theme,theme],[1,1,1],[0,90,160],rotation);
			graphics.lineStyle(1,ColorUtil.adjustBrightness(darkTheme,-50),1);
			draw(unscaledWidth,unscaledHeight);
			this.filters = [];
		}
		override protected function drawDownSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			drawUpSkin(unscaledWidth,unscaledHeight);
		}
	}
}