package it.lisit.siss.flex.core
{
	import flash.events.Event;

	public class WaitPopUpEvent extends Event
	{
		public static const HIDE:String		= "hide";
		public static const HIDE_IMMEDIATE:String = "hideImmediate";
		public static const SHOW:String		= "show";
		public static const UPDATE:String	= "update";
		//
		public var info:Object;
		public function WaitPopUpEvent(type:String, info:Object = null)
		{
			super(type);
			this.info	= info; 
		}
	}
}