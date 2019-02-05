package com.li.dc.sebc.turboFSE.events
{
	import flash.events.Event;

	public class SelectItems extends Event
	{
		public static const SELECT_ITEMS:String = "selectItems";
		public var items:Array
		public function SelectItems(items:Array)
		{
			super(SELECT_ITEMS);
			this.items = items;
		}
	}
}