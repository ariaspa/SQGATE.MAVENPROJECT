package it.lisit.siss.flex.color
{
	import it.lisit.siss.flex.color.IColor;
	public class XColor implements IColor
	{
		private var _name:String
		private var _color:uint;
		//
		public function get name():String{
			return _name;
		}
		public function XColor(name:String,color:uint){
			_name = name;
			_color = color	
		}
		public function getColor():uint{
			return _color;
		}
	}
}