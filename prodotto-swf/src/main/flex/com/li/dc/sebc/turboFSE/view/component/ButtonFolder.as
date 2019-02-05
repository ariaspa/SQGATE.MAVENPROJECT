package com.li.dc.sebc.turboFSE.view.component
{
	import com.li.dc.sebc.turboFSE.view.skin.IconButtonFolder;
	
	import mx.controls.Button;

	public class ButtonFolder extends Button
	{
		public function ButtonFolder()
		{
			super();
			this.setStyle("upIcon",IconButtonFolder);
			this.setStyle("overIcon",IconButtonFolder);
			this.setStyle("downIcon",IconButtonFolder);
			this.setStyle("selectedUpIcon",IconButtonFolder);
			this.setStyle("selectedOverIcon",IconButtonFolder);
			this.setStyle("selectedDownIcon",IconButtonFolder);
			this.setStyle("skin",SkinBut);
			this.setStyle("fontSize",12);
			this.setStyle("textAlign","left");
			this.labelPlacement = "right";
			this.toggle = true;
		}
	}
}

	import mx.skins.halo.ButtonSkin;
	import mx.utils.ColorUtil;

class SkinBut extends ButtonSkin
{
	public function SkinBut()
	{
		super();
	}
	private function drawRectT(w:Number, h:Number,col1:int,col2:int):void
	{
		graphics.lineStyle(3,col1,0.5);
		graphics.drawRect(0,0,w,h);
		graphics.endFill();
		graphics.lineStyle(2,col2,0.5);
		graphics.drawRect(4,4,w-8,h-8);
		graphics.endFill();
	}
	override protected function updateDisplayList(w:Number, h:Number):void
	{
   		var col:int = 0xFFFFFF;
		graphics.clear();			
		switch (name)
		{		
			case "selectedUpSkin":
			case "upSkin":
			case "selectedOverSkin":
			case "overSkin":
			case "selectedDownSkin":
			case "downSkin":
			drawRectT(w,h,0xFFFFFF,0);
			break;
		}
	}
}