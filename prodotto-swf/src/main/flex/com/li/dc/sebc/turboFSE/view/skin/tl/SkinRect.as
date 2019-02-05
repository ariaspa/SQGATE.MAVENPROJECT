package com.li.dc.sebc.turboFSE.view.skin.tl
{
	import flash.display.GradientType;
	
	import it.lispa.siss.sebc.flex.graphic.timeline.skin.SkinDefault;
	
	public class SkinRect extends SkinDefault
	{
		public function SkinRect()
		{
			super();
		}
		protected function drawLineRect(p:Object):void
		{
			graphics.lineStyle(1,p.themeColor,0.8);
			graphics.drawRect(p.x, p.y, p.w, p.h);
			graphics.endFill();
		}
		protected function drawGradientRect(p:Object):void
	 	{
	 		graphics.beginGradientFill(p.gradientType,p.colors,p.alphas,p.ratios,p.matrix);
			//GraphicsUtils.drawRect(graphics,p.x,p.y,p.w,p.h,[0]);
			graphics.drawRect(p.x, p.y, p.w, p.h);
			graphics.endFill();
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
			
			p1.w 				= p.w ;
			p1.h 				= p.h ;
			p1.x 				= p.x ;
			p1.y 				= p.y ;
			
			p1.gradientType 	= GradientType.LINEAR;
			
			p1.colors			= [ p.themeColor, p.themeColorDrk1 ];
			p1.alphas			= [ 1, 1 ];
			p1.ratios			= [ 0, 0xFF ];
			p1.matrix			= verticalGradientMatrix(0, 0, p.w, p.h );
			// button border/edge
			drawGradientRect(p1);
			// button fill
			p1.colors			= overFillColors;
			p1.alphas			= overFillAlphas;
			p1.matrix			= verticalGradientMatrix(1, 1, p.w - 2, p.h - 2);
			 
			drawGradientRect(p1);
			// top highlight
			p1.colors			= [ 0xFFFFFF, 0xFFFFFF ];
			p1.alphas			= p.highlightAlphas;
			p1.matrix			= verticalGradientMatrix(1, 1, p.w - 2, (p.h - 2) / 2);
			 
			drawGradientRect(p1);	
		}
		protected function drawUpSkinParam(p:Object):void
		{
			 
			 var p1:Object		= {};
			p1.gradientType 	= GradientType.LINEAR;
			p1.w 				= p.w ;
			p1.h 				= p.h ;
			p1.x 				= p.x ;
			p1.y 				= p.y ;  
			p1.colors			= [ p.borderColor, p.borderColorDrk1 ];
			p1.alphas			= [ 1, 1 ];
			p1.ratios			= [ 0, 0xFF ];
			p1.matrix			= verticalGradientMatrix(0, 0, p.w, p.h );
			// button border/edge
			drawGradientRect(p1);
			// button fill
			p1.colors			= [ p.fillColors[0], p.fillColors[1] ];
			p1.alphas			= [ p.fillAlphas[0], p.fillAlphas[1] ];
			p1.matrix			= verticalGradientMatrix(1, 1, p.w - 2, p.h - 2);
			 
			drawGradientRect(p1);
			// top highlight
			p1.colors			= [ 0xFFFFFF, 0xFFFFFF ];
			p1.alphas			= p.highlightAlphas;
			p1.matrix			= verticalGradientMatrix(1, 1, p.w - 2, (p.h - 2) / 2);
			 
			drawGradientRect(p1);	
			 
		}
		protected function drawDownSkinParam(p:Object):void
		{
			 
			var p1:Object		= {};
			p1.gradientType 	= GradientType.LINEAR;
			p1.w 				= p.w ;
			p1.h 				= p.h ;
			p1.x 				= p.x ;
			p1.y 				= p.y ; 
			p1.colors			= [ p.themeColor, p.themeColorDrk1 ];
			p1.alphas			= [ 1, 1 ];
			p1.ratios			= [ 0, 0xFF ];
			p1.matrix			= verticalGradientMatrix(0, 0, p.w, p.h );
			// button border/edge
			drawGradientRect(p1);
			// button fill
			p1.colors			= [ p.fillColors[0], p.fillColors[1] ];
			p1.alphas			= [ p.fillAlphas[0], p.fillAlphas[1] ];
			p1.matrix			= verticalGradientMatrix(1, 1, p.w - 2, p.h - 2);
			drawGradientRect(p1);
			// top highlight
			p1.colors			= [ 0xFFFFFF, 0xFFFFFF ];
			p1.alphas			= [0.2,0.8];
			p1.matrix			= verticalGradientMatrix(1, 1, p.w - 2, (p.h - 2) / 2);
			drawGradientRect(p1);	
		}
	}
}