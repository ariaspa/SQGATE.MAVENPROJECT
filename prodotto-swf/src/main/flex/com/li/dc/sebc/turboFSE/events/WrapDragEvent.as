package com.li.dc.sebc.turboFSE.events
{
	 
	import flash.events.Event;
	
	import mx.events.DragEvent;

	public class WrapDragEvent extends Event
	{
		public static const DRAG_ENTER:String 		= "dragEnter"; 
		public static const DRAG_DROP:String 		= "dragDrop"; 
		public static const DRAG_COMPLETE:String 	= "dragComplete"; 
		public static const DRAG_EXIT:String 		= "dragExit"; 
		public static const DRAG_OVER:String 		= "dragOver"; 
		public static const DRAG_START:String 		= "dragStart"; 
		
		private var _dragEvent:DragEvent;
		public function WrapDragEvent(type:String,dragEvent:DragEvent)
		{
			super(type);
			_dragEvent = dragEvent;
		}
		public function getEvent():DragEvent
		{
			return _dragEvent;
		}
	}
}