package com.li.dc.sebc.turboFSE.util
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	
	import it.lisit.siss.flex.utility.debug.IFormatLog;
	import it.lispa.siss.sebc.flex.debug.IConsole;
	
	 

	public class RemoteConsole implements IConsole
	{
		private var formatLog:IFormatLog;
		public function RemoteConsole()
		{
			formatLog 	= new RemoteFormat();
		}

		public function get consoleFilter():Boolean
		{
			return false;
		}
		
		public function set consoleFilter(value:Boolean):void
		{
		}
		public function write(message:Object, level:uint, levelDebug:uint=0):void
		{
			var msg:String = formatLog.getFormatString(message,level,levelDebug);
			FactoryService.getInstance().getOpeConsole( msg , level , levelDebug ).execute();
		}
	}
}
	import it.lisit.siss.flex.utility.debug.IFormatLog;
	import it.lisit.siss.flex.utility.debug.DebugUtils;
	
class RemoteFormat implements IFormatLog
{
	private static var counter:uint = 0;
	public function getFormatString(message:Object,level:uint,levelDebug:uint=0):String
	{
		counter++;
		//var lev:String 		= getLevel(level);
		//var logDate:String 	= getDate();
		var msgg:String		= (message is String) ? message as String :  message.toString();
		var msg:String = "-FLEX-MSG-> "+counter+" <-\n["+msgg+"]"; 
		return msg;
	}
	private function getDate():String
	{
		return DebugUtils.getCompleteStringDate();
	}
	private function getLevel(level:uint):String
	{
		return DebugUtils.getStringLevel( level );
	}
}

