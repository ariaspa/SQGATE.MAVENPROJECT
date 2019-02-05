package com.li.dc.sebc.turboFSE.view.skin.tl
{
	public class SkinCircleThin extends SkinCircle
	{
		public function SkinCircleThin()
		{
			super();
		}
		override protected function drawUpSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var param:Object = addMeasures(unscaledWidth,unscaledHeight);
			graphics.clear();
			drawUpSkinParam( param ); 
		}
	  
		override protected function drawOverSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var param:Object = addMeasures(unscaledWidth,unscaledHeight);	
			graphics.clear();
			param.radius = param.radius-1;
			drawOverSkinParam( param );
		}
	  
		override protected function drawDownSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var param:Object = addMeasures(unscaledWidth,unscaledHeight);
			graphics.clear();
			param.radius = param.radius+2;
			drawDownSkinParam( param );
		}
	}
}