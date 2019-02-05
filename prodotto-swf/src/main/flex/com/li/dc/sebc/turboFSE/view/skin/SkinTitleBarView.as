package com.li.dc.sebc.turboFSE.view.skin
{
	import flash.display.Graphics;
	import flash.filters.DropShadowFilter;
	
	import mx.core.mx_internal;
	import mx.skins.Border;
	import mx.utils.ColorUtil;
	use namespace mx_internal;
	public class SkinTitleBarView extends Border
	{
		public function SkinTitleBarView()
		{
			super();
		}
		protected override function updateDisplayList(unscaledWidth:Number,
									     unscaledHeight:Number):void
		{
			var bckcolor:int = this.getStyle("backgroundColor") as int;
			var bckalpha:Number = this.getStyle("backgroundAlpha") as Number;
			var radius:Number = this.getStyle("cornerRadius") as Number;
			var g:Graphics = this.graphics;
			g.clear();
			g.beginFill(bckcolor,bckalpha);
			g.drawRoundRectComplex(0,0,unscaledWidth,unscaledHeight,radius,radius,0,0);
			g.endFill();
			//
			var colLine1:uint = ColorUtil.adjustBrightness(bckcolor,-80);
			g.lineStyle(0.8,colLine1,bckalpha);
			g.drawRoundRectComplex(0,0,unscaledWidth,unscaledHeight,radius,radius,0,0);
			g.endFill();
			//
			var colLine:uint = ColorUtil.adjustBrightness(bckcolor,-120);
			g.lineStyle(2,colLine,bckalpha);
			g.moveTo(1,unscaledHeight);
			g.lineTo(unscaledWidth-1,unscaledHeight);
			g.endFill();
				
		}
	}
}