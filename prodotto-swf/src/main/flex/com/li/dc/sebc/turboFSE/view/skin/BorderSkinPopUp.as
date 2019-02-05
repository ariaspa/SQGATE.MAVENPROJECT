package com.li.dc.sebc.turboFSE.view.skin
{
	import flash.display.Graphics;
	
	import mx.skins.ProgrammaticSkin;

	public class BorderSkinPopUp extends ProgrammaticSkin
	{
		public function BorderSkinPopUp()
		{
			super();
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			 var g:Graphics = graphics;
			 g.clear();
			 var c:int 		= getStyle("cornerRadius");
			 var col:int 	= getStyle("backgroundColor");
			 g.beginFill(col,1);
			 
			 g.drawRoundRectComplex(0,0,unscaledWidth,unscaledHeight,c,c,0,0);
			 g.endFill();
		}
	}
}