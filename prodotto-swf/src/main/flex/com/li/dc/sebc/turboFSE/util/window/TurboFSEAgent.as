package com.li.dc.sebc.turboFSE.util.window
{
	import flash.events.AsyncErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import it.lisit.siss.agent.Agent;
	import it.lisit.siss.agent.AgentReceptionEvent;
	import it.lisit.siss.agent.AgentStateEvent;
	import it.lisit.siss.agent.AgentSynchronousEvent;
	import it.lispa.siss.sebc.flex.debug.Debug;
	
	/**
	 * rappresenta il fse agent 
	 * @author marco
	 * 
	 */	
	public class TurboFSEAgent
	{
		public static const COMMAND:String 			= "_command_";
		public static const CLOSE:String 			= "close";
		public static const MOVE:String 			= "move";
		public static const RESIZE:String 			= "resize";
		public static const FOCUS:String 			= "focus";
		public static const LOAD:String 			= "load";
		public static const LOAD_MODULE:String 		= "loadModule";
		public static const PING:String 			= "ping";
		public static const CHANGE_TITLE:String 	= "changeTitle";
		//
		public static const FREEZER_WINDOW:String 	= "freezerWindow";
		public static const DEFREEZER_WINDOW:String = "defreezerWindow";
		//
		private static var instance:TurboFSEAgent; 
		public static function getInstance():TurboFSEAgent
		{
			if(instance==null)
			{
				instance = new TurboFSEAgent();
			}
			return instance
		}
		////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////
		private var flagPing:Boolean = false;
		private var idIntervalPing:int;
		private var agent:Agent;
		
		private var dictWindow:Dictionary;
		private var lastMessage:Dictionary;
		private var nullCheck:Boolean	= false;
		private var remove:Array;
		  
		public function TurboFSEAgent()
		{
			dictWindow 	= new Dictionary(true);
		 	remove = new Array();
			agent  = new Agent("_FSEFLEX");
			agent.allowInsecureDomain("*");
			setListener(agent);
			agent.startConnection();	
		}
		private function setListener(agent:Agent):void
		{
			agent.addEventListener(AgentReceptionEvent.AGENT_RECEPTION_COMPLETE,onCompleteData);
			agent.addEventListener(AgentStateEvent.SEND,onSend);
			agent.addEventListener(AgentSynchronousEvent.SYNCHRONOUS_EVENT,onStatus,false,1000);
			agent.addEventListener(AsyncErrorEvent.ASYNC_ERROR,onAsyncError);
			agent.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
		}
		private function removeListener(agent:Agent):void
		{
			agent.removeEventListener(AgentReceptionEvent.AGENT_RECEPTION_COMPLETE,onCompleteData);
			agent.removeEventListener(AgentStateEvent.SEND,onSend);
			agent.removeEventListener(AgentSynchronousEvent.SYNCHRONOUS_EVENT,onStatus);
			agent.removeEventListener(AsyncErrorEvent.ASYNC_ERROR,onAsyncError);
			agent.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
		}
		public function registerWindow(window:AgentWindow):void
		{
			nullCheck = true;
			//removeWindow( window );
			nullCheck = false;
			dictWindow[window.name] = window;
		}
		public function removeWindow(window:AgentWindow):void
		{
			remove.push( window.name );
			dictWindow[window.name] = null;
			delete dictWindow[window.name];
			 
			if(!nullCheck)
				checkPing();
		}
		private function getWindow(name:String):AgentWindow
		{
			return dictWindow[name];
		}
		private function existWinds():Boolean
		{
			var t:Array = new Array();
			for(var o:Object in dictWindow)
			{
				if(dictWindow[o] != null && dictWindow[o] is AgentWindow)
				{
					t.push( o );
				}	
			}
			return (t.length>0);
		}
		internal function checkPing():void
		{
			if(existWinds())
			{
				openPing();
			}else
			{
				closePing();
			}
		}
		private function openPing():void
		{
			if(!flagPing)
			{
				flagPing = true;
				idIntervalPing = setInterval(pingWin,1500);		
			}
		}
		private function closePing():void
		{
			if(flagPing)
			{
				flagPing = false;
				clearInterval(idIntervalPing);
			}
		}
	 
		private function pingWin():void
		{
			closePing();
			
			var list:Array = new Array();
			for(var o:Object in dictWindow)
			{
				var name:* = o;
				if(name!=null && name is String && String(name).length>0)
				{
					list.push( name );
				}
			}
			if(list.length>0)
			{
				var obj:Object = {};
				obj.list = list;
				obj.ping = ping;
				obj.openPing = checkPing;
				obj.counter = 0; 
				obj.idInterval = setInterval(function(obj:Object):void
				{
					if(obj.counter<obj.list.length)
					{
						var name:String = obj.list[obj.counter];
						obj.ping(name);
					}else
					{
						clearInterval(obj.idInterval);
						obj.openPing();
					}
					obj.counter++;
				},150,obj);
			}
		}
		
		private function ping(name:String):void
		{
			if(name!=null)
			{
				var agent:AgentWindow = getWindow(name);
				if(agent!=null && agent.isOpenWindow)
				{
					sendToWindow(name,[TurboFSEAgent.COMMAND,TurboFSEAgent.PING]);
				}
			}
		}
		public function sendToWindow(name:String,params:Array):void
		{
			if(getWindow(name)!=null)
			{
				agent.send(name,params);
			}
		}
		private function onStatus(e:AgentSynchronousEvent):void
		{
			var lev:String	= e.level;
			if(lev!=null && lev  == "error")
			{
				
				var agent:AgentWindow = getWindow( e.connection );
				if(agent !=null )
				{
					Debug.logDebug("TurboFSEAgent.onStatus removeWindow and closeAgent name : "+agent.name);
					removeWindow(agent);
					// 
					agent.closeAgent();
				}
			}
		}
		
		 
		///////////////////////////////////////////////////////////
		private function onCompleteData(e:AgentReceptionEvent):void
		{
			var sender:String 		= e.sender;
			var data:Array			= e.data;
			var window:AgentWindow 	= getWindow(sender);
			if(window!=null)
			{
				Debug.logInfo("TurboFSEAgent ARRIVANO DATI DA "+window.name+"\ndata["+data+"]");
				if(window !=null && data!=null && data.length>0)
				{
					window.receiveData( data );
				}
			}
		}
		private function onSend(e:AgentStateEvent):void
		{}
		
		private function onAsyncError(e:AsyncErrorEvent):void
		{
		 
			if(e.error!=null)
			{
				Debug.logInfo("TurboFSEAgent.onAsyncError - : "+e.error.message);
			}
		}
		private function onSecurityError(e:SecurityErrorEvent):void
		{
			Debug.logInfo("TurboFSEAgent.onSecurityError - : "+e.text);
		}
		
	}
}