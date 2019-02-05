package com.li.dc.sebc.turboFSE.view.skin.tl
{
	import it.lispa.siss.sebc.flex.graphic.timeline.skin.SkinDefault;

	public class SkinLine extends SkinDefault
	{
		public function SkinLine()
		{
			super();
		}
		override protected function drawOverSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			 drawUpSkin(unscaledWidth,unscaledHeight);
		}
		override protected function drawUpSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			 var col:int 	= getStyle("themeColor");
			 var h:Number 	= unscaledHeight/3;
			 graphics.clear();
			 // bck
			 graphics.beginFill(col,0.01);
			 graphics.drawRect(0, 0, unscaledWidth, unscaledHeight );
			 graphics.endFill();
			 //
			 graphics.beginFill(col,1);
			 graphics.drawRect(0, h, unscaledWidth, h );
			 graphics.endFill();
		}
		override protected function drawDownSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			  drawUpSkin(unscaledWidth,unscaledHeight);
		}
	}
}