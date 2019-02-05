package com.li.dc.sebc.turboFSE.util
{
	import flash.events.AsyncErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	import it.lisit.siss.agent.Agent;
	import it.lispa.siss.sebc.flex.debug.IConsole;
	import it.lispa.siss.sebc.flex.debug.IFormatLog;
	import it.lispa.siss.sebc.flex.debug.TraceFormatLog; 
	public class LocalConnectionConsole implements IConsole
	{
		private var _agent:Agent;
		private var _target:String;
		private var _filter:Boolean;
		private var formatLog:IFormatLog; 
		public function LocalConnectionConsole(nameDebug:String,nameConsole:String)
		{
			formatLog 		= new TraceFormatLog();
			_target = nameConsole;
			_filter = false;
			_agent 	= new Agent(nameDebug);
			_agent.allowInsecureDomain("*");
			_agent.addEventListener(AsyncErrorEvent.ASYNC_ERROR,onError);
			_agent.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurity);
			_agent.startConnection();
		}
		private function onError(e:AsyncErrorEvent):void  
		{
			trace("message-> "+e.error.message);
		}
		private function onSecurity(e:SecurityErrorEvent):void  
		{
			trace("message-> "+e.text);
		}
		public function get consoleFilter():Boolean
		{
			return _filter;
		}
		
		public function set consoleFilter(value:Boolean):void
		{
			_filter = value;
		}
		
		public function write(message:Object, level:uint, levelDebug:uint=0):void
		{
			if(_agent.isConnect)
			{
				var msg:String = formatLog.getFormatString(message,level,levelDebug);
				_agent.send( _target, [msg,level,levelDebug,_filter] );
			}
		}
	}
}