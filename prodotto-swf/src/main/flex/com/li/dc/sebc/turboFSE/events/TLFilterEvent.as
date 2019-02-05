package com.li.dc.sebc.turboFSE.events
{
	import flash.events.Event;

	public class TLFilterEvent extends Event
	{
		public static const TLFILTER_EVENT:String = "TLFilterEvent";
		private var _list:Array;
		public function TLFilterEvent(type:String,listItem:Array)
		{
			super(type);
			_list = listItem;
		}
		public function getList():Array
		{
			return _list;
		}
	}
}