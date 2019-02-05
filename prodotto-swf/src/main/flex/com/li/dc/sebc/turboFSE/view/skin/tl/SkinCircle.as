package com.li.dc.sebc.turboFSE.view.skin.tl
{
	import flash.display.GradientType;
	import flash.geom.Point;
	
	import it.lispa.siss.sebc.flex.graphic.timeline.skin.SkinDefault;
	import it.lispa.siss.sebc.flex.utils.GraphicsUtils;
	
	public class SkinCircle extends SkinDefault
	{
		public function SkinCircle()
		{
			super();
		}
		protected function addMeasures(w:Number,h:Number):Object
		{
			var param:Object 			= getObjectParam();
			var m: Number				= Math.min(w,h);
	 		param.centerPoint 			= new Point(m/2,m/2);
	 		param.radius 				= param.centerPoint.y;
			param.w						= m;
			param.h						= m;
			param.min					= m;
			return param;
		}
		protected function drawDownSkinParam(p:Object):void
		{
			var p1:Object		= {};
			p1.gradientType 	= GradientType.LINEAR;
			p1.w 				= p.w;
			p1.h 				= p.h;
			p1.centerPoint 		= p.centerPoint;
			p1.radius 			= p.radius;
			p1.colors			= [ p.themeColor, p.themeColorDrk1 ];
			p1.alphas			= [ 1, 1 ];
			p1.ratios			= [ 0, 0xFF ];
			p1.matrix			= verticalGradientMatrix(0, 0, p.w, p.h );
			// button border/edge
			drawGradientCircle(p1);
			// button fill
			p1.colors			= [ p.fillColors[0], p.fillColors[1] ];
			p1.alphas			= [ p.fillAlphas[0], p.fillAlphas[1] ];
			p1.matrix			= verticalGradientMatrix(1, 1, p.w - 2, p.h - 2);
			p1.radius 			= p.radius - 2;
			drawGradientCircle(p1);
			// top highlight
			p1.colors			= [ 0xFFFFFF, 0xFFFFFF ];
			p1.alphas			= [0.2,0.8];
			p1.matrix			= verticalGradientMatrix(1, 1, p.w - 2, (p.h - 2) / 2);
			p1.radius 			= (p.radius - 2);
			drawGradientCircle(p1);	
		}
		protected function drawOverSkinParam(p:Object):void
		{
			var overFillColors:Array;
			if (p.fillColors.length > 2)
				overFillColors = [ p.fillColors[2], p.fillColors[3] ];
			else
				overFillColors = [ p.fillColors[0], p.fillColors[1] ];

			var overFillAlphas:Array;
			if (p.fillAlphas.length > 2)
				overFillAlphas = [ p.fillAlphas[2], p.fillAlphas[3] ];
  			else
				overFillAlphas = [ p.fillAlphas[0], p.fillAlphas[1] ];
					
			var p1:Object		= {};
			p1.gradientType 		= GradientType.LINEAR;
			p1.w 				= p.w;
			p1.h 				= p.h;
			p1.centerPoint 		= p.centerPoint;
			p1.radius 			= p.radius;
			p1.colors			= [ p.themeColor, p.themeColorDrk1 ];
			p1.alphas			= [ 1, 1 ];
			p1.ratios			= [ 0, 0xFF ];
			p1.matrix			= verticalGradientMatrix(0, 0, p.w, p.h );
			// button border/edge
			drawGradientCircle(p1);
			// button fill
			p1.colors			= overFillColors;
			p1.alphas			= overFillAlphas;
			p1.matrix			= verticalGradientMatrix(1, 1, p.w - 2, p.h - 2);
			p1.radius 			= p.radius - 2;
			drawGradientCircle(p1);
			// top highlight
			p1.colors			= [ 0xFFFFFF, 0xFFFFFF ];
			p1.alphas			= p.highlightAlphas;
			p1.matrix			= verticalGradientMatrix(1, 1, p.w - 2, (p.h - 2) / 2);
			p1.radius 			= (p.radius - 2) / 2
			drawGradientCircle(p1);	
		}
		protected function drawUpSkinParam(p:Object):void
		{
			var p1:Object		= {};
			p1.gradientType 	= GradientType.LINEAR;
			p1.w 				= p.w;
			p1.h 				= p.h;
			p1.centerPoint 		= p.centerPoint;
			p1.radius 			= p.radius;
			p1.colors			= [ p.borderColor, p.borderColorDrk1 ];
			p1.alphas			= [ 1, 1 ];
			p1.ratios			= [ 0, 0xFF ];
			p1.matrix			= verticalGradientMatrix(0, 0, p.w, p.h );
			// button border/edge
			drawGradientCircle(p1);
			// button fill
			p1.colors			= [ p.fillColors[0], p.fillColors[1] ];
			p1.alphas			= [ p.fillAlphas[0], p.fillAlphas[1] ];
			p1.matrix			= verticalGradientMatrix(1, 1, p.w - 2, p.h - 2);
			p1.radius 			= p.radius - 2;
			drawGradientCircle(p1);
			// top highlight
			p1.colors			= [ 0xFFFFFF, 0xFFFFFF ];
			p1.alphas			= p.highlightAlphas;
			p1.matrix			= verticalGradientMatrix(1, 1, p.w - 2, (p.h - 2) / 2);
			p1.radius 			= (p.radius - 2) / 2
			drawGradientCircle(p1);	
		}
	 	protected function drawGradientCircle(p:Object):void
	 	{
	 		graphics.beginGradientFill(p.gradientType,p.colors,p.alphas,p.ratios,p.matrix);
			GraphicsUtils.drawCircle( graphics, p.centerPoint, p.radius );
			graphics.endFill();
	 	} 	
	}
}