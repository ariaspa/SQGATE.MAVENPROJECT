package com.li.dc.sebc.turboFSE.view.component
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	import it.lispa.siss.sebc.flex.color.UtilsColor;
	
	import mx.core.UIComponent;
	// import it.lispa.siss.sebc.flex.color.UtilsColor;
	public class Divisore extends UIComponent
	{
		public function Divisore()
		{
			super();
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList( unscaledWidth, unscaledHeight);
			var c:Object 	= this.getStyle("backgroundColor");
			if(c==null)
			{
				c = 0xADF0A6;
			}
			var def:int 		= c as int;
			var c1:int 			= UtilsColor.adjustBrightness(def,-125)
			var colors:Array 	= [c1,def,0xFFFFFF,def,c1];
			var alphas:Array	= [1,1,1,1,1];
			var rat:Array		= [0,64,128,192,255]
			var g:Graphics 		= this.graphics;
			g.clear();
			var m:Matrix = new Matrix();
			m.createGradientBox(unscaledWidth, unscaledHeight, Math.PI);
			g.beginGradientFill(GradientType.LINEAR,
								colors, 
								alphas, 
								rat, m);
			g.drawRect(0,0,	unscaledWidth,	unscaledHeight);
			g.endFill();			
		}
	}
}