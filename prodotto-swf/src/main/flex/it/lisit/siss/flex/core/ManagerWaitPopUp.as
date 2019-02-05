package it.lisit.siss.flex.core
{
	import flash.events.EventDispatcher;
	
	import it.lisit.siss.flex.sebwebsiss;
	use namespace sebwebsiss;
	[Event(name="show", type="it.lisit.siss.flex.core.WaitPopUpEvent")]
	[Event(name="update", type="it.lisit.siss.flex.core.WaitPopUpEvent")]
	[Event(name="hide", type="it.lisit.siss.flex.core.WaitPopUpEvent")]
	[Event(name="hideImmediate", type="it.lisit.siss.flex.core.WaitPopUpEvent")]
	public class ManagerWaitPopUp extends EventDispatcher
	{
		private static var instance:ManagerWaitPopUp;
		public static function getInstance():ManagerWaitPopUp
		{
			if(instance==null)
			{
				instance = new ManagerWaitPopUp();
			}
			return instance;
		}
		////////////////////////////////////////////////////
		private var _displayerWait:IDisplayerWait;
		public function set displayerWait(value:IDisplayerWait):void
		{
			_displayerWait = value;
		}
		public function get displayerWait():IDisplayerWait
		{
			return (_displayerWait!=null) ? _displayerWait : defaultDisplayerWait;
		}
		/**
		 * indica se deve essere usata l'oggetto di display del wait 
		 */		
		public var useDisplayer:Boolean;
		private var defaultDisplayerWait:IDisplayerWait;
		private var infoShow:Object;
		private var inUse:Boolean;
		public function ManagerWaitPopUp()
		{
			super(this);
			inUse = false;
			useDisplayer = true;
			defaultDisplayerWait = new DefaultDisplayerWait();
		}
		private function getDisplayer():IDisplayerWait
		{
			return useDisplayer ? displayerWait : null;
		}
		public function update(info:Object=null):void
		{
			if(inUse)
			{
				var disp:IDisplayerWait =  getDisplayer();
				if(disp!=null)
					disp.update( info );
				this.dispatchEvent( new WaitPopUpEvent(WaitPopUpEvent.UPDATE,info) );
			}
		}
		sebwebsiss function hideImmediate():void
		{
			if(inUse)
			{
				var disp:IDisplayerWait =  getDisplayer();
				if(disp!=null)
				{
					inUse = false;
					disp.hideImmediate();
				}
				this.dispatchEvent( new WaitPopUpEvent(WaitPopUpEvent.HIDE_IMMEDIATE) );
			}
		}
		public function hide():void
		{
			if(inUse)
			{
				var disp:IDisplayerWait =  getDisplayer();
				if(disp!=null)
				{
					disp.callbackAfterHide( closeWait );
					disp.hide();
				}else
				{
					closeWait();
				}
			}
		}
		public function show(info:Object=null):void
		{
			infoShow	= info;
			var disp:IDisplayerWait =  getDisplayer();
			if(disp!=null)
			{
				inUse = true;
				disp.callbackAfterShow( showWait);
				disp.show( info );
			}else
			{
				showWait();
			}	
		}
		private function showWait():void
		{
			this.dispatchEvent( new WaitPopUpEvent(WaitPopUpEvent.SHOW,infoShow) );
		}
		private function closeWait():void
		{
			inUse = false;
			this.dispatchEvent( new WaitPopUpEvent(WaitPopUpEvent.HIDE) );
		}
		private function fakeCloseWait():void{}
	}
}