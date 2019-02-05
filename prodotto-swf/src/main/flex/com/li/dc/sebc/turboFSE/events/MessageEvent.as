package com.li.dc.sebc.turboFSE.events
{
	import flash.events.Event;

	public class MessageEvent extends Event
	{
		public static const MESSAGE_EVENT:String 	= "messageEvent";
		public static const CHANGE_PROVINCIA:String = "changeProvincia";
		
		private var _val:String;
		public function getValue():String{return _val;}
		public function MessageEvent(type:String,message:String)
		{
			super(type);
			_val = message;
		}
	}
}