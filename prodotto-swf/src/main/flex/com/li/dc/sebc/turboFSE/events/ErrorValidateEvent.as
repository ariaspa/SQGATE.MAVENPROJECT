package com.li.dc.sebc.turboFSE.events
{
	import flash.events.Event;

	public class ErrorValidateEvent extends Event
	{
		public static const ERROR_VALIDATE_EVENT:String = "errorValidateEvent";
		private var _error:Array;
		public function getErrors():Array{return _error;}
		
		public function ErrorValidateEvent(type:String,err:Array )
		{
			super(type);
			this._error = err;
		}
		
	}
}