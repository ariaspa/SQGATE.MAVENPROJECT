package it.lisit.siss.flex.color
{
	import it.lisit.siss.flex.color.IColor;
	import it.lisit.siss.flex.color.RGBColor;
	/**
	 * 
	 * @author marco
	 * 
	 */
	public class CMYKColor implements IColor
	{
		private var fc:uint;
		private var fm:uint;
		private var fy:uint;
		/**
		* aaaa
		*/
		private var fk:uint;
		//
		public function get cyan():uint{
			return fc;
		}
		public function set cyan(v:uint):void{
			fc = (v>100) ? 100 : v;
		}
		//////////
		public function get magenta():uint{
			return fm;
		}
		public function set magenta(v:uint):void{
			fm = (v>100) ? 100 : v;
		}
		//////////
		public function get yellow():uint{
			return fy;
		}
		public function set yellow(v:uint):void{
			fy = (v>100) ? 100 : v;
		}
		//////////
		public function get black():uint{
			return fk;
		}
		public function set black(v:uint):void{
			fk = (v>100) ? 100 : v;
		}
		public function CMYKColor(c:uint,m:uint,y:uint,k:uint){
			cyan  = c;
			magenta = m;
			yellow = y;
			black = k;
		}
		public function toRGB():RGBColor {
			var bla:Number = black/100;
			var cya:Number = cyan/100;
			var mag:Number = magenta/100;
			var yel:Number = yellow/100;
			//
			var red:Number = Math.round(255*(1-bla+cya*(bla-1)));
			var gre:Number = Math.round(255*(1-bla+mag*(bla-1)));
			var blu:Number = Math.round(255*(1-bla+yel*(bla-1)));
			var val:Number = (red << 16 | gre << 8 | blu << 0);
			var r:Number = (val >> 16) & 0xFF;
			var g:Number = (val >> 8) & 0xFF;
			var b:Number = (val >> 0) & 0xFF;
			//
			return new RGBColor(uint(r), uint(g),uint(b));
		}
		public function setColor(color:uint):void
		{
			var cmyk:CMYKColor 	= UtilsColor.colorToRGBColor( color ).toCMYK();
			this.cyan			= cmyk.cyan;
			this.black			= cmyk.black;
			this.magenta		= cmyk.magenta;
			this.yellow			= cmyk.yellow;
		}
		public function getColor():uint
		{
			return toRGB().getColor();
		}
	}
}