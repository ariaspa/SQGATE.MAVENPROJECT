package it.lisit.siss.flex.color
{
	import it.lisit.siss.flex.color.IColor;
	import it.lisit.siss.flex.color.RGBColor;
	public class HSBColor implements IColor
	{
		private var hh:Number;
		private var ss:Number;
		private var bb:Number;
		//
		public function set brightness (val:Number):void{
			bb = (val>100) ? 100 : ((val<0) ? 0 : val);
		}
		public function set saturation (val:Number):void{
			ss = (val>100) ? 100 : ((val<0) ? 0 : val);
		}
		public function set hue (val:Number):void{
			hh = (val>=360) ? val%360 : ((val<0) ? 360+(val%360): val);
		}
		public function get brightness ():Number{
			return bb;
		}
		public function get saturation():Number{
			return ss;
		}
		public function get hue():Number{
			return hh;
		}
		public function HSBColor(h:Number=0,s:Number=0,b:Number=0){
			hue = h;
			saturation = s;
			brightness = b;
		}
		public function toRGB():RGBColor {
			var r:Number=0;
			var g:Number=0;
			var b:Number=0;
			if(saturation == 0) {
				// achromatic (grey)
				r = g = b = brightness;
				return new RGBColor(uint(r),uint(g),uint(b));
			}
			// sector 0 to 5
			var h:Number =  hue/60;
			// factorial part of h
			var f:Number = h - Math.floor(h);			
			var i:uint = uint(h);
			var ss:Number = saturation/100
			var bb:Number = brightness/100;
			// factorial part of h
			f = h - i;			
			var p:Number = bb * ( 1 - ss );
			var q:Number = bb * ( 1 - ss * f );
			var t:Number = bb * ( 1 - ss * ( 1 - f ) );
			switch( i ) {
				case 0:
					r = bb*255;
					g = t*255;
					b = p*255;
					break;
				case 1:
					r = q*255;
					g = bb*255;
					b = p*255;
					break;
				case 2:
					r = p*255;
					g = bb*255;
					b = t*255;
					break;
				case 3:
					r = p*255;
					g = q*255;
					b = bb*255;
					break;
				case 4:
					r = t*255;
					g = p*255;
					b = bb*255;
					break;
				default:
					// case 5:		
					r = bb*255;
					g = p*255;
					b = q*255;
					break;
			}
			return new RGBColor(uint(r),uint(g),uint(b))
    	}
    	public function setColor(color:uint):void
    	{
    		var hsb:HSBColor	= UtilsColor.colorToRGBColor( color ).toHSB();
    		this.hue			= hsb.hue; 
    		this.saturation		= hsb.saturation; 
    		this.brightness		= hsb.brightness; 
    	}
    	public function getColor():uint
    	{
    		return toRGB().getColor();
    	}
	}
}