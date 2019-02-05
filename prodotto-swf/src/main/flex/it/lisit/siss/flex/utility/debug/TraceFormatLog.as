package it.lisit.siss.flex.utility.debug
{
	public class TraceFormatLog implements IFormatLog
	{
		private static var counter:uint = 0;
		public function TraceFormatLog()
		{
		}
		public function getFormatString(message:Object, level:uint, levelDebug:uint=0):String
		{
			counter++;
			var lev:String 		= getLevel(level);
			var logDate:String 	= getDate();
			var msgg:String		= (message is String) ? message as String :  message.toString();
			var msg:String = "[MSG "+counter+" - DATE "+logDate+" - LEVEL : "+lev+"] "+msgg; 
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
}