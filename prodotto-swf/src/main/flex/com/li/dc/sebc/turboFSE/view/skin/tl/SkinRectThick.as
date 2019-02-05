package com.li.dc.sebc.turboFSE.view.skin.tl
{
	import flash.geom.Point;
	
	import it.lispa.siss.sebc.flex.utils.GraphicsUtils;
	
	public class SkinRectThick extends SkinRect
	{
		public function SkinRectThick()
		{
			super();
		}
		private function drawDash(p:Object):void
	 	{
	 		graphics.lineStyle(1.5,p.themeColor,0.7); 
			  
			GraphicsUtils.drawLine(this.graphics,new Point(p.x,p.y),new Point(p.x+p.w,p.y) );
			GraphicsUtils.drawLine(this.graphics,new Point(p.x+p.w,p.y),new Point(p.x+p.w,p.y+p.h) );
			GraphicsUtils.drawLine(this.graphics,new Point(p.x+p.w,p.y+p.h),new Point(p.x,p.y+p.h) );
			GraphicsUtils.drawLine(this.graphics,new Point(p.x,p.y+p.h),new Point(p.x,p.y) );
			 
			graphics.endFill(); 
	 	}
		override protected function drawOverSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var p:Object		= getObjectParam();
			p.fillAlphas  		= [1,1];
			p.fillColors 		= [p.themeColor,p.themeColor];
			p.w 				= unscaledWidth;
			p.h 				= unscaledHeight;
			p.x 				= 0;
			p.y 				= 0;
			drawOverSkinParam( p );
			p.w 				= unscaledWidth-2;
			p.h 				= unscaledHeight-2;
			p.x 				= 1;
			p.y 				= 1;
			drawDash(p); 
		}
		override protected function drawUpSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var p:Object		= getObjectParam();
			p.fillAlphas  		= [1,1];
			p.fillColors 		= [p.themeColor,p.themeColor];
			p.w 				= unscaledWidth;
			p.h 				= unscaledHeight;
			p.x 				= 0;
			p.y 				= 0;
			drawUpSkinParam( p );
			 
			drawDash(p);
		}
		override protected function drawDownSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var p:Object		= getObjectParam();
			p.fillAlphas  		= [1,1];
			p.fillColors 		= [p.themeColor,p.themeColor];
			p.w 				= unscaledWidth;
			p.h 				= unscaledHeight;
			p.x 				= 0;
			p.y 				= 0;
			drawDownSkinParam( p );
			p.w 				= unscaledWidth+6;
			p.h 				= unscaledHeight+6;
			p.x 				= -3;
			p.y 				= -3;
			drawDash(p);
		}
	}
}