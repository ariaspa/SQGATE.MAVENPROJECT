package com.li.dc.sebc.turboFSE.events
{
	import flash.events.Event;

	public class TabFSEEvent extends Event
	{
		public static const TAB_FSE_INDEX_CHANGE:String = "tabFSEIndexChange";
		private var _index:int;
		public function TabFSEEvent(type:String, index:int)
		{
			super(type, bubbles, cancelable);
			_index = index;
		}
		public function getIndex():int{return _index;} 
	}
}
