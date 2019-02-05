package com.li.dc.sebc.turboFSE.view.component
{
	import mx.controls.Button;

	public class ButtonSkin extends Button
	{
		public function ButtonSkin()
		{
			super();
		}
		override public function setStyle(styleProp:String, newValue:*):void
		{
			super.setStyle(styleProp,newValue );
			if(styleProp=="skin")
			{
				super.setStyle("upSkin",newValue );
				super.setStyle("overSkin",newValue );
				super.setStyle("downSkin",newValue );
				super.setStyle("disabledSkin",newValue );
				super.setStyle("selectedUpSkin",newValue );
				super.setStyle("selectedOverSkin",newValue );
				super.setStyle("selectedDownSkin",newValue );
				super.setStyle("selectedDisabledSkin",newValue );
			}
		}
	}
}