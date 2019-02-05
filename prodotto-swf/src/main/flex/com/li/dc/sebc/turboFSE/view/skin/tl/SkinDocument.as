package com.li.dc.sebc.turboFSE.view.skin.tl
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.GlowFilter;
	
	import it.lispa.siss.sebc.flex.graphic.timeline.model.DataDocument;
	import it.lispa.siss.sebc.flex.graphic.timeline.skin.SkinDefault;

	public class SkinDocument extends SkinDefault
	{
		[Embed(source="../../../../../../../../../resources/images/ico_copia_18.gif")]  
        [Bindable] private var ICO_DOC:Class;
		
		public function SkinDocument()
		{
			super();
		}
		private function toARGB(rgb:uint, newAlpha:uint):uint{
		  var argb:uint = 0;
		  argb = (rgb);
		  argb += (newAlpha<<24);
		  return argb;
		}
		
		private function changePix(pix:uint):Boolean
		{
			return pix <= 0xFFFFFFFF && pix >= 0xFFB5B1B3;
		}
		override protected function drawOverSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			drawUpSkin(unscaledWidth,unscaledHeight);
			this.filters	= [new GlowFilter(getStyle("themeColor"),0.7,12,12)];
		}
		override protected function drawUpSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var bit:Bitmap				= new ICO_DOC() as Bitmap;
			var data:BitmapData			= bit.bitmapData;
			var bitmapData:BitmapData 	= new BitmapData(bit.width, bit.height,true,getStyle("themeColor"));
			var c:int 					= (0xFF << 24) + getStyle("themeColor");
			  
			//bitmapData.threshold(bit.bitmapData, new Rectangle(0, 0, data.width, data.height), new Point(0, 0), ">=", 0xFFFFFF, 0xFFFF00, 0xffffff, true);
			for(var xx:uint = 0;xx<data.width;xx++)
			{
				for(var yy:uint = 0;yy<data.height;yy++)
				{
					var pix:uint = data.getPixel32(xx,yy);
					bitmapData.setPixel32(xx,yy,changePix(pix) ? c : pix);
				}
			}
			graphics.beginBitmapFill(bitmapData);
			graphics.drawRect(0,0,bit.width,bit.height);
			graphics.endFill();
			this.filters	= [];
		}
		override protected function drawDownSkin(unscaledWidth:Number, unscaledHeight:Number):void
		{
			drawUpSkin(unscaledWidth,unscaledHeight);
		}
	}
}