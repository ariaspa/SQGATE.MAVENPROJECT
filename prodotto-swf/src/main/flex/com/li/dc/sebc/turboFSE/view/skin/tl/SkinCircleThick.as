package com.li.dc.sebc.turboFSE.view.skin.tl
{
	import it.lispa.siss.sebc.flex.utils.GraphicsUtils;
	
	public class SkinCircleThick extends SkinCircle
	{
		public function SkinCircleThick()
		{
			super();
		}
		private function drawDash(p:Object):void
	 	{
	 		graphics.lineStyle(1.5,p.themeColor,0.7); 
			GraphicsUtils.drawCircle( graphics, p.centerPoint, p.radius );
			graphics.endFill(); 
	 	}
	 	 
		override protected function drawUpSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var param:Object = addMeasures(unscaledWidth,unscaledHeight);
			
			graphics.clear();
			
			drawUpSkinParam( param );
			 
			drawDash(param); 
		}
	  
		override protected function drawOverSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			
			var param:Object = addMeasures(unscaledWidth,unscaledHeight);
			
			graphics.clear();
			
			drawOverSkinParam( param );
			
			param.radius = param.radius-1;
			drawDash(param); 
			 
		}
	  
		override protected function drawDownSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var param:Object = addMeasures(unscaledWidth,unscaledHeight);
			
			graphics.clear();
			
			drawDownSkinParam( param );
			
			param.radius = param.radius+2;
			drawDash(param); 
		}
	}
}