package com.li.dc.sebc.turboFSE.view.component
{
	import it.lispa.siss.sebc.flex.help.IDropDragClass;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import mx.controls.Button;
	import mx.controls.Image;
	import mx.core.IFlexDisplayObject;

	public class ButtonDragInfo extends Button implements IDropDragClass
	{
		public function ButtonDragInfo()
		{
			super();
		}
		public function getProxyImage():IFlexDisplayObject 
		{
			var bit:BitmapData 	= new BitmapData(this.width+2,this.height+2,true,0x00000000);
			bit.draw(this);
			var imProxy:Image	= new Image();
			var map:Bitmap		= new Bitmap( bit );
			imProxy.source		= map;
			return imProxy;
		}
	}
}