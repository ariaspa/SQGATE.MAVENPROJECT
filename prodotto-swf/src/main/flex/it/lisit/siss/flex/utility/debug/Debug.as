package it.lisit.siss.flex.utility.debug
{
	
	import flash.utils.Dictionary;
	/**
	 * 
	 * @author Marco Salonia
	 * 
	 */	
	public class Debug
	{
		//==================================================================================//
		private static var consoles:Dictionary;
		private static function initDebug():uint
		{
			consoles = new Dictionary();
			addConsole(CONSOLE_DEFAULT,new TraceConsole());
			return DebugLevel.DEBUG;
		}
		//==================================================================================//
		public static const CONSOLE_DEFAULT:String = "__internal_name_default_console__";
		public static var level:uint = initDebug();
		//==================================================================================//
		public static function existConsole(name:String):Boolean
		{
			return !(consoles[name]==null);
		}
		public static function addConsole(name:String,console:IConsole):Boolean
		{
			if(!existConsole(name))
			{
				consoles[name] = console;
				return true;
			}
			return false;
		}
		public static function removeConsole(name:String):Boolean
		{
			if(existConsole(name))
			{
				delete consoles[name];
				return true;
			}
			return false;
		} 
		public static function getConsole(name:String):IConsole
		{
			if(existConsole(name))
			{
				return consoles[name];
			}
			return null;
		}
		public static function logDebug(message:Object):void
		{
			internalLog(message,DebugLevel.DEBUG);
		}  
		public static function logInfo(message:Object):void
		{
			internalLog(message,DebugLevel.INFO);
		}  
		public static function logWarning(message:Object):void
		{
			internalLog(message,DebugLevel.WARNING);
		}  
		public static function logError(message:Object):void
		{
			internalLog(message,DebugLevel.ERROR);
		}  
		public static function logFatal(message:Object):void
		{
			internalLog(message,DebugLevel.FATAL);
		}  
		private static function internalLog(message:Object,lvl:uint):void
		{
			for(var s:String in consoles)
			{
				var console:IConsole = consoles[s];
				if(console.consoleFilter)
				{
					console.write(message,lvl,level);
				}else
				{
					if(lvl>=level)
					{
						console.write(message,lvl,level);
					}
				}
			}
		}  
	}
}