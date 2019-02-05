package it.lisit.siss.flex.color
{
	import mx.utils.ColorUtil;
	 
	public class RGBColor implements IColor
	{
		private var r:uint;
		private var g:uint;
		private var b:uint;
		public function get red():uint
		{
			return r;
		}
		public function set red(v:uint):void
		{
			r=(v>255)? 255:((v<0)? 0 : v);
		}
		public function get blue():uint{
			return b;
		}
		public function set blue(v:uint):void{
			b = (v>255)? 255:((v<0)? 0 : v);
		}
		public function get green():uint{
			return g;
		}
		public function set green(v:uint):void{
			g=(v>255)? 255:((v<0)? 0 : v);
		}
		public function getColor():uint
		{
			return createValue();
		}
		public function setColor(color:uint):void
    	{
    		var rgb:RGBColor	= UtilsColor.colorToRGBColor( color );
    		this.red			= rgb.red; 
    		this.green			= rgb.green; 
    		this.blue			= rgb.blue; 
    	}
		/* costruttore */
		public function RGBColor(r:uint,g:uint,b:uint)
		{
			red		=r;
			green	=g;
			blue	=b;
		}
		private function createValue():uint{
			//return ((red & 0xFF) << 16) | ((green & 0xFF) << 8)  | ((blue & 0xFF) << 0);
			return UtilsColor.rgbToColor( this.red, this.green, this.blue );
		}
		public function brighter(brite:Number):void 
		{
			this.setColor( UtilsColor.adjustBrightness(this.getColor(),brite) );        
	    }
    	public function toCMYK():CMYKColor {
			var cy:uint = 100-Math.round(100/(255/red));
			var ma:uint = 100-Math.round(100/(255/green));
			var ye:uint = 100-Math.round(100/(255/blue));
			return new CMYKColor(cy, ma, ye,0);
		}
		
		public function toHSB():HSBColor {
			var saturation:Number = 0;
			var brightness:Number = 0;
			var hue:Number=0;
			var min:Number = 0;
			var max:Number = 0;
			var delta:Number = 0;
			var r:Number = red/255;
			var g:Number = green/255;
			var b:Number = blue/255;
			//
			min = Math.min( r, g, b );
			max = Math.max( r, g, b );
			brightness = max*100;
			delta = max - min;
			if( max != 0 ){
				saturation = (delta / max)*100;
			}else {
				// r = g = b = 0	
				// s = 0, v is undefined
				saturation = 0;
				hue = 0;
				brightness = 0;
				return new HSBColor(hue,saturation,brightness);
			}
			if( r == max ){
				// between yellow & magenta
				hue = (( g - b )==0 &&  delta==0) ? 0 : ( g - b )/ delta;		
			}else if( g == max ){
				// between cyan & yellow
				hue = 2 + ((( b - r )==0 &&  delta==0) ? 0 : ( b - r )/ delta);
			}else{
				// between magenta & cyan
				hue = 4 + ((( r - g )==0 &&  delta==0) ? 0 : ( r - g )/ delta);
			}
			// degrees
			hue = hue*60;
					
			if( hue < 0 ){
				hue += 360;
			}
			return new HSBColor(hue,saturation,brightness);
		}
	}
}