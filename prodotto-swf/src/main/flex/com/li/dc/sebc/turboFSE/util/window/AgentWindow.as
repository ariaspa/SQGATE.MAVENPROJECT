package com.li.dc.sebc.turboFSE.util.window
{
	import com.li.dc.sebc.turboFSE.events.WindowEvent;
	
	import flash.events.EventDispatcher;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	[Event(name="openWindow", type="com.li.dc.sebc.turboFSE.events.WindowEvent")] 
	[Event(name="loadWindow", type="com.li.dc.sebc.turboFSE.events.WindowEvent")] 
	[Event(name="moveWindow", type="com.li.dc.sebc.turboFSE.events.WindowEvent")]
	[Event(name="resizeWindow", type="com.li.dc.sebc.turboFSE.events.WindowEvent")]
	[Event(name="focusWindow", type="com.li.dc.sebc.turboFSE.events.WindowEvent")]
	[Event(name="closeWindow", type="com.li.dc.sebc.turboFSE.events.WindowEvent")]
	[Event(name="loadModule", type="com.li.dc.sebc.turboFSE.events.WindowEvent")]
	[Event(name="receptionData", type="com.li.dc.sebc.turboFSE.events.WindowEvent")]
	public class AgentWindow extends EventDispatcher
	{
		private var _name:String;
		private var _loadWindow:Boolean = false;
		private var idTimeOut:int;
		private var _lastFocus:Boolean 	= false;
		private var isOpen:Boolean 		= false;
		public function get isOpenWindow():Boolean{return isOpen;}
		public function get name():String
		{
			return _name;
		}
		public function AgentWindow(name:String)
		{
			super(this);
			Debug.logDebug("AgentWindow start name : " +name);
			_name = name;
			TurboFSEAgent.getInstance().registerWindow( this );
			idTimeOut = setInterval(timeOutFun,6000);
		}
		private function timeOutFun():void
		{
			if(!_loadWindow)
			{
				Debug.logInfo("AgentWindow.timeOutFun  ");
				// fuori tempo
				clearInterval( idTimeOut );
				closeAgent();
			}
		}
		private function sendDispatchMove(x:Number,y:Number):void
		{
			dispatchEvent(new WindowEvent(WindowEvent.MOVE_WINDOW,[x,y]));
		}
		private function sendDispatchResize(w:Number,h:Number):void
		{
			dispatchEvent(new WindowEvent(WindowEvent.RESIZE_WINDOW,[w,h]));
		} 
		
		private function sendDispatchLoadModule():void
		{
			dispatchEvent(new WindowEvent(WindowEvent.LOAD_MODULE));
		}
		public function focus(flag:Boolean):void
		{
			Debug.logDebug("AgentWindow focus _lastFocus: "+_lastFocus +", flag : "+flag);
			if(_lastFocus!=flag )
			{
				_lastFocus = flag;
				if(_lastFocus)
				{
					this.send([TurboFSEAgent.COMMAND,TurboFSEAgent.FOCUS]);
				}
			}
		}
		// mi arriva dalla finestra 
		private function sendDispatchFocus(fcs:Boolean):void
		{
			_lastFocus = fcs;
			GestWindows.getInstance().getReference(this.name).getDataAgregazione().inFocus = _lastFocus;
			dispatchEvent(new WindowEvent(WindowEvent.FOCUS_WINDOW));
		}
		public function send(params:Array):void
		{
			Debug.logInfo("AgentWindow.send name "+this.name+", params : "+params);
			TurboFSEAgent.getInstance().sendToWindow(this.name , params );
		}
		private function loadWindow():void
		{
			if(!_loadWindow)
			{
				Debug.logInfo("AgentWindow.loadWindow ");
				isOpen = true;
				_loadWindow = true;
				// da ora faccio partire il ping
				TurboFSEAgent.getInstance().checkPing();
				dispatchEvent(new WindowEvent(WindowEvent.LOAD_WINDOW));
			}
		}
		private function sendDispatchData(dt:Array):void
		{
			Debug.logDebug("AgentWindow.sendDispatchData dt : "+dt);
			dispatchEvent(new WindowEvent(WindowEvent.RECEPTION_DATA,dt));
		}	
		public function receiveData(dt:Array):void
		{
			Debug.logDebug("AgentWindow.receiveData dt : "+dt);
			if(dt.length>=2 && dt[0] is String && dt[1] is String)
			{
				var param1:String 	= dt[0];
				if(dt[0] == TurboFSEAgent.COMMAND)
				{
					var command:String	= dt[1];
					switch(command)
					{
						case TurboFSEAgent.LOAD:
							loadWindow();
							break;
						case TurboFSEAgent.LOAD_MODULE:
							sendDispatchLoadModule();
							break;
						case TurboFSEAgent.MOVE:
							sendDispatchMove(dt[2],dt[3]);
							break;
						case TurboFSEAgent.RESIZE:
							sendDispatchResize(dt[2],dt[3]);
							break;
						case TurboFSEAgent.FOCUS:
							sendDispatchFocus(true);
							break;
						default:
							checkSend(dt);
					}
				}else
				{
					checkSend(dt);
				}
			}
		}
		
		private function checkSend(dt:Array):void
		{
			if (!_loadWindow) 
			{
				loadWindow();
				sendDispatchLoadModule();
			}else{
				sendDispatchData(dt);
			}
		}
		// chiamato SOLO da TurboFSEAgent da cui sono stato appena rimosso
		internal function closeAgent():void
		{
			Debug.logInfo("AgentWindow.closeAgent " );
			this.isOpen = false;
			GestWindows.getInstance().getReference(this.name).getDataAgregazione().isSelect = false;
			dispatchEvent( new WindowEvent(WindowEvent.CLOSE_WINDOW ) );	
		} 
		// arriva da bottone
		public function close():void
		{
			Debug.logInfo("AgentWindow.close  "+this.name+", isOpen "+this.isOpen);
			if(this.isOpen)
			{
				this.isOpen = false;
				send([TurboFSEAgent.COMMAND,TurboFSEAgent.CLOSE]);
				TurboFSEAgent.getInstance().removeWindow( this );
			}
		}
	}
}
	 
	
	 

 