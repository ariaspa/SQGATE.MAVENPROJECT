package com.li.dc.sebc.turboFSE.events
{
	import flash.events.Event;

	public class WindowEvent extends Event
	{
		public static const OPEN_WINDOW:String 		= "openWindow";
		public static const LOAD_WINDOW:String 		= "loadWindow";
		public static const MOVE_WINDOW:String 		= "moveWindow";
		public static const RESIZE_WINDOW:String 	= "resizeWindow";
		public static const FOCUS_WINDOW:String 	= "focusWindow";
		public static const CLOSE_WINDOW:String 	= "closeWindow";
		public static const LOAD_MODULE:String 		= "loadModule";
		public static const RECEPTION_DATA:String 	= "receptionData";
		////////////
		private var _data:Array;
		public function get data():Array{return _data;}
		public function WindowEvent(type:String, dt:Array = null)
		{
			super(type);
			_data = (dt == null) ? [] : dt;
		}
	}
}