package com.li.dc.sebc.turboFSE.events
{
	import com.li.dc.sebc.turboFSE.model.vo.DataIdentificaCittadino;
	
	import flash.events.Event;

	public class DataIdentificaCittadinoEvent extends Event
	{
		public static const IDENTIFICA_CITTADINO_EVENT:String = "identificaCittadinoEvent";
		public function getData():DataIdentificaCittadino
		{
			return this.data;
		}
		private var data:DataIdentificaCittadino; 
		public function DataIdentificaCittadinoEvent(type:String,data:DataIdentificaCittadino)
		{
			super(IDENTIFICA_CITTADINO_EVENT);
			this.data = data;
		}
		
	}
}