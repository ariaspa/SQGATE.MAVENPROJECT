package com.li.dc.sebc.turboFSE.events
{
	import flash.events.Event;

	public class ToggleEvent extends Event
	{
		public static const TOGGLE_EVENT:String = "toggleEvent";
		public var selected:Boolean;
		public function ToggleEvent(type:String,select:Boolean)
		{
			super(type);
			selected = select;
		}
	}
}