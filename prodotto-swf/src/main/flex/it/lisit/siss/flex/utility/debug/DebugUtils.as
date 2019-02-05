package it.lisit.siss.flex.utility.debug
{
	public class DebugUtils
	{
		public static function getStringDate():String
		{
			var dt:Date = new Date();
			return dt.toLocaleTimeString();
		}
		public static function getCompleteStringDate():String
		{
			var dt:Date = new Date();
			var day:String		= ""+dt.date;
			var month:String	= ""+(dt.month+1);
			var year:String		= ""+dt.fullYear;
			var h:String 		= ""+dt.hours;
			var m:String 		= ""+dt.minutes;
			var s:String 		= ""+dt.seconds;
			var ml:String 		=""+dt.milliseconds;
			var data:String		= "("+day+":"+month+":"+year+")";
			var time:String 	= data +" "+h+":"+m+":"+s+":"+ml;
			return time;
		}
		public static function getStringLevel(level:uint):String
		{
			var output:String = "";
			switch(level)
			{
				case DebugLevel.DEBUG:
				output = "DEBUG";
				break;
				case DebugLevel.INFO:
				output = "INFO";
				break;
				case DebugLevel.WARNING:
				output = "WARNING";
				break;
				case DebugLevel.ERROR:
				output = "ERROR";
				break;
				case DebugLevel.FATAL:
				output = "FATAL";
				break;
				default :
				output = "UNKNOW";
				break;
			}
			return output;
		}
	}
}