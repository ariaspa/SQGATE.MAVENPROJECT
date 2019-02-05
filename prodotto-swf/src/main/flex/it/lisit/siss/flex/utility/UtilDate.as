package it.lisit.siss.flex.utility
{
	import mx.formatters.DateFormatter;
	
	public class UtilDate
	{
		 public static const MAJOR_AGE:int 	= 18;	 
		 public static const MESI:Array	 	= ['Gennaio','Febbraio','Marzo','Aprile','Maggio','Giugno','Luglio','Agosto','Settembre','Ottobre','Novembre','Dicembre'];
		 public static const GIORNI:Array 	= ["D", "L", "M", "M", "G", "V", "S"];
		 /**
		  *	calcola la differenza di anni fra le due date;  
		  * @param startDate:Date Data di partenza
		  * @param endDate:Date Data di finale
		  * @return age:int differenza anni
		  * 
		  */
		 public static function diferenceYearDate(startDate:Date,endDate:Date):int
		 {
		 	return  endDate.fullYear - startDate.fullYear;
		 }
		 /**
		 * Calcola gli anni di vita per una determinata data di nascita.
		 * @param dataNascita:Date Data di nascita
		 * @param dataNascita:Date Data di nascita
		 * @return age:int Anni di età
		 */
		public static function getEta(dataNascita:Date,today:Date):int
		{
			var difference:int = diferenceYearDate(dataNascita,today); 
			if(difference<=0)
			{
				return 0;
			}
			if ((today) < (new Date((dataNascita.fullYear + difference), dataNascita.month, dataNascita.date))) 
				difference--; 
			return difference;
		}
		/**
		 * @param dataNascita:Date
		 * @return Booelan Se true la data si riferisce ad un maggiorenne.
		 */
		public static function isMaggiorenne(dataNascita:Date,today:Date):Boolean
		{
			return (getEta(dataNascita,today) >= MAJOR_AGE);
		}
		/**
		 * Stringa di almeno 8 caratteri nel formato '20001231' dove i primi 4 caratteri sono gli anni 
		 * i secondi due il mese gli utimi due il giorno
		 * @param dt  
		 * @return Date 
		 * 
		 */		
		public static function fromStringToDate(dt:String):Date
  		{
  		 	if(dt.length<8)return null;
  		 	var year:String		 = dt.substring(0,4);
     		var month:String	 = dt.substring(4,6);	 
     		var day:String	 	 = dt.substring(6);	 
     		return new Date(int(year),int(month)-1,int(day));
  		}
  		//////////////////////////////////////////////////////////////
  		private static var formatter:DateFormatter; 
  		public static const FORMATTER_STRING:String = "DD/MM/YYYY"; 
  		public static function formatterDate(data:Date,formatString:String=null):String
  		{
  			if(formatter==null)
  			{
  				formatter = new DateFormatter();
  			}
  			formatter.formatString = (formatString == null) ? FORMATTER_STRING : formatString;	
  			return formatter.format( data );
  		}
	}
}