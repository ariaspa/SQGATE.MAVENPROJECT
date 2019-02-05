package com.li.dc.sebc.turboFSE.events
{
	import flash.events.Event;

	public class ChangeProvinciaEvent extends Event
	{
		public static const CHANGE_PROVINCIA:String = "changeProvincia";
		private var _val:String;
		public function getValue():String{return _val;}
		public function ChangeProvinciaEvent(type:String,value:String)
		{
			super(type);
			this._val	= value;
		}
		
	}
}