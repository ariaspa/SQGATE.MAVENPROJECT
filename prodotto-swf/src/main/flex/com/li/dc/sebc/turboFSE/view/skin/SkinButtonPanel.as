package com.li.dc.sebc.turboFSE.view.skin
{
	import mx.skins.halo.ButtonSkin;
	import mx.styles.StyleManager;
	import mx.utils.ColorUtil;

	public class SkinButtonPanel extends ButtonSkin
	{
		public function SkinButtonPanel()
		{
			super();
		}
		override protected function updateDisplayList(w:Number, h:Number):void
		{	
			var cornerRadius:Number = getStyle("cornerRadius");
			super.updateDisplayList(w-2, h-2);
			switch (name)
			{
				case "selectedUpSkin":
				case "selectedOverSkin":
				case "selectedDownSkin":
				case "selectedDisabledSkin":
				graphics.lineStyle(2,0xFCFF00,1);
				graphics.drawRoundRect(-1,-1,w,h,cornerRadius,cornerRadius);
				graphics.endFill();
				break;
			}
		}
	}
}