package com.li.dc.sebc.turboFSE.util
{
	import mx.formatters.DateFormatter;
	import mx.utils.StringUtil;
	
	public class UtilDate
	{
		public static const MAJOR_AGE:int 	= 18;	 
		public static const MESI:Array	 	= ['Gennaio','Febbraio','Marzo','Aprile','Maggio','Giugno','Luglio','Agosto','Settembre','Ottobre','Novembre','Dicembre'];
		public static const GIORNI:Array 	= ["D", "L", "M", "M", "G", "V", "S"];
		private static var formatter:DateFormatter; 
  		public static const FORMATTER_STRING:String = "DD/MM/YYYY"; 
  		public static const FORMATTER_STRING_DATA:String = "YYYYMMDD"; 
		
  		public static function formatterDate(data:Date,formatString:String=null):String
  		{
  			if(formatter==null)
  			{
  				formatter = new DateFormatter();
  			}
  			formatter.formatString = (formatString == null) ? FORMATTER_STRING : formatString;	
  			return formatter.format( data );
  		}
  		 
  		/**
		 * Stringa di almeno 8 caratteri nel formato '20001231' dove i primi 4 caratteri sono gli anni 
		 * i secondi due il mese gli utimi due il giorno
		 * @param dt  
		 * @return Date 
		 * 
		 */		
		public static function fromStringToDate(dat:String):Date
  		{
  			// YYYYMMDDHH24MM
  			var dt:String = StringUtil.trim(dat);
  		 	if(dt.length<8)return null;
  		 	var year:String		 = dt.substring(0,4);
     		var month:String	 = dt.substring(4,6);	 
     		var day:String	 	 = dt.substring(6,8);	 
     		var hour:String		 = "00";
     		var min:String		 = "00";
     		if(dt.length>8)
     		{
     			hour	= dt.substring(8,10);
     			min		= dt.substring(10,12);
     		}
     		return new Date(int(year),int(month)-1,int(day),int(hour),int(min));
  		}
  		/* Precisione fino alle ore  */
		public static function isEquals(start:Date,end:Date):Boolean
		{
			if(start==null || end==null)
			{
				return false;
			}
			if(start.getFullYear()== end.getFullYear())
			{
				if(start.getMonth() == end.getMonth())
				{
					if(start.getDate()== end.getDate())
					{
						if(start.getHours()== end.getHours())
						{
							return true;
						}
					}
				}
			} 
			return false;
		}
		public static function isMajor(start:Date,end:Date):Boolean
		{
			if(start==null || end==null)
			{
				return false;
			}
			if(start.getFullYear()>end.getFullYear())
			{
				return true;
			}else if(start.getFullYear()==end.getFullYear())
			{
				if(start.getMonth() > end.getMonth())
				{
					return true;
				}else if(start.getMonth() == end.getMonth())
				{
					if(start.getDate()>end.getDate())
					{
						return true;
					}else if(start.getDate()==end.getDate())
					{
						if(start.getHours()>end.getHours())
						{
							return true;				
						}
					}
				}
			}
			return false;
		}  		
  		public static function getStringDataAndOra(dat:String=null):String
		{
			var dt:String	= StringUtil.trim(dat);
			var data:String = "";
			if(dt==null || dt.length==0)return data;
			var ora:String  = "";
			if(dt.length>0)
			{
				data = getStringData(dt);
				ora  = getStringOra(dt.substring(8));
			}
			var res:String	= data + ((ora.length>0) ? " - " + ora : "");
			return res;
		}
  		public static function getStringData(dt:String):String
		{
			var out:String = "";
			if(dt !=null && dt.length>0)
			{
				var anno:String = dt.substring(0,4);
				var mese:String = dt.substring(4,6);
				var giorno:String = dt.substring(6,8);
				out = giorno + "/" + mese + "/" + anno;
			}
			return out;
		}
		public static function getStringOra(dt:String):String
		{
			var out:String 		= "";
			if(dt.length>=6)
			{
				var ora:String 		= dt.substring(0,2);
				var minuti:String 	= dt.substring(2,4);
				var secondi:String	= dt.substring(4,6);
				var milli:String    = ",";
				if(dt.length>6)
				{
					milli  += dt.substring(6);
				}
				out  = ora + "."+minuti+"."+secondi;
				if(milli.length>1) out += milli;
			}
			return out;
		}
		
		
	}
}