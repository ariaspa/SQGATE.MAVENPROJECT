package com.li.dc.sebc.turboFSE.view.skin.tl
{
	import flash.filters.DropShadowFilter;
	
	public class SkinRectThinSelect extends SkinRectThin
	{
		public function SkinRectThinSelect()
		{
			super();
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			this.filters = [new DropShadowFilter(8)];
		}
	}
}