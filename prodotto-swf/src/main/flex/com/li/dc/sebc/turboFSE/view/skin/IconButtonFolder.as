package com.li.dc.sebc.turboFSE.view.skin
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	import mx.skins.ProgrammaticSkin;

	public class IconButtonFolder extends ProgrammaticSkin
	{
		public function IconButtonFolder()
		{
			super();
		}
		override protected function updateDisplayList(unscaledWidth:Number,unscaledHeight:Number):void
		{
			this.graphics.clear();
			 
			var colr:uint = 0;
			var alph:Number = 0.4;
			this.graphics.beginFill(colr,alph);
			  
			switch(name)
			{
				case "upIcon":
				case "overIcon":
				case "downIcon":
					this.graphics.moveTo(0,0);
					this.graphics.lineTo(unscaledWidth,unscaledHeight/2);
					this.graphics.lineTo(0,unscaledHeight);
					this.graphics.lineTo(0,0);
				break;
				case "selectedUpIcon":
				case "selectedOverIcon":
				case "selectedDownIcon":
					this.graphics.moveTo(0,0);
					this.graphics.lineTo(unscaledWidth,0);
					this.graphics.lineTo(unscaledWidth/2,unscaledHeight);
					this.graphics.lineTo(0,0);
				break;
			}
			
			/*this.graphics.moveTo(0,0);
			this.graphics.lineTo(unscaledWidth,unscaledHeight/2);
			this.graphics.lineTo(0,unscaledHeight);
			this.graphics.lineTo(0,0);
			this.graphics.endFill();*/
		}
		override public function get measuredWidth():Number
	    {
	        return 14;
	    }
	    override public function get measuredHeight():Number
	    {
	        return 14;
	    }
	}
}