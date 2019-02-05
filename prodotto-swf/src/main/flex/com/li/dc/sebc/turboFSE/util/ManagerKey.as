package com.li.dc.sebc.turboFSE.util
{
	import flash.events.KeyboardEvent;
	
	import mx.core.Application;
	
	public class ManagerKey
	{
		private static var _app:Application;
		public static function init(app:Application):void
		{
			_app = app;
			_app.addEventListener(KeyboardEvent.KEY_DOWN , onKeyEvent);
		}
		private static function onKeyEvent(e:KeyboardEvent):void
		{
			//var altkey:Boolean = e.altKey;
			//var altkey:Boolean = e.altKey;
		}
	}
}