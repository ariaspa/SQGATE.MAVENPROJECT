package it.lisit.siss.flex.color
{
	import it.lisit.siss.flex.color.*;
	public class UtilsColor
	{
		public static function colorToRGBColor(rgb:uint):RGBColor
		{
			var r:uint = (rgb >> 16)& 0xFF;
			var g:uint = (rgb >> 8) & 0xFF;
			var b:uint = (rgb >> 0) & 0xFF;
			return new RGBColor(r,g,b);
		}
		public static function rgbToColor(r:uint,g:uint,b:uint):uint
		{
			//var rgb:RGBColor = new RGBColor(r,g,b);
			//return rgb.getColor();
			return ((r & 0xFF) << 16) | ((g & 0xFF) << 8)  | ((b & 0xFF) << 0);
		}
		public static function rgbToHexString(rgb:RGBColor):String
		{
			var res:String = ""+Number(rgb.red).toString(16)+Number(rgb.green).toString(16)+Number(rgb.blue).toString(16);
			return "#"+res.toUpperCase();
		}	
		public static function colorToHexString(rgb:uint):String	
		{
			return rgbToHexString( colorToRGBColor(rgb) );
		}
		//
		public static function adjustBrightness(rgb:uint, brite:Number):uint
		{
			var r:Number = Math.max(Math.min(((rgb >> 16) & 0xFF) + brite, 255), 0);
			var g:Number = Math.max(Math.min(((rgb >> 8) & 0xFF) + brite, 255), 0);
			var b:Number = Math.max(Math.min((rgb & 0xFF) + brite, 255), 0);
			
			return (r << 16) | (g << 8) | b;
		} 
		public static function dilayColors(colorIni:uint,colorEnd:uint,step:uint):Array
		{
			var temp:Array = new Array();
			var rgbIni:RGBColor = colorToRGBColor(colorIni);
			var rgbEnd:RGBColor = colorToRGBColor(colorEnd);
			var rgb:RGBColor = new RGBColor(rgbIni.red,rgbIni.green,rgbIni.blue);
			var rs:uint = Math.round((rgbEnd.red-rgbIni.red)/step);
			var gs:uint = Math.round((rgbEnd.green-rgbIni.green)/step);
			var bs:uint = Math.round((rgbEnd.blue-rgbIni.blue)/step);
			for(var i:uint = 0;i<step;i++){
				rgb.red +=rs;
				rgb.green +=gs;
				rgb.blue +=bs;
				temp.push(rgb.getColor());
			}
			return temp;
		}
	}
}
