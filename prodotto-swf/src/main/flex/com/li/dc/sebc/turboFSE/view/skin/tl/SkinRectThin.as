package com.li.dc.sebc.turboFSE.view.skin.tl
{
	public class SkinRectThin extends SkinRect
	{
		public function SkinRectThin()
		{
			super();
		}
		override protected function drawOverSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var p:Object		= getObjectParam();
			p.fillAlphas		= [1,1];
			p.w 				= unscaledWidth-2;
			p.h 				= unscaledHeight-2;
			p.x 				= 1;
			p.y 				= 1;
			drawOverSkinParam( p );
			drawLineRect( p );
		}
		override protected function drawUpSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var p:Object		= getObjectParam();
			p.fillAlphas		= [1,1];
			p.w 				= unscaledWidth;
			p.h 				= unscaledHeight;
			p.x 				= 0;
			p.y 				= 0;
			drawUpSkinParam( p );
			drawLineRect( p );
		}
		override protected function drawDownSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var p:Object		= getObjectParam();
			p.fillAlphas		= [1,1];
			p.w 				= unscaledWidth+6;
			p.h 				= unscaledHeight+6;
			p.x 				= -3;
			p.y 				= -3;
			drawDownSkinParam( p );
			drawLineRect( p );
		}
	}
}