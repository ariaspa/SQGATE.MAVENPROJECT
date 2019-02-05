package it.lisit.siss.flex.utility.debug
{
	public class TraceConsole implements IConsole
	{
		public function get consoleFilter():Boolean{return false;}
		public function set consoleFilter(value:Boolean):void{ }
		public var formatLog:IFormatLog;
		public function TraceConsole()
		{
			consoleFilter 	= false;
			formatLog 		= new TraceFormatLog();
		}
		public function write(message:Object, level:uint,levelDebug:uint=DebugLevel.DEBUG):void
		{
			var msg:String = formatLog.getFormatString(message,level,levelDebug);
			trace(msg);
		}
	}
}