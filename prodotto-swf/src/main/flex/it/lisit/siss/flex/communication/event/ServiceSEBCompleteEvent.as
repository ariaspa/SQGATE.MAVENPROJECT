package it.lisit.siss.flex.communication.event
{
	import flash.events.Event;
	
	import it.lisit.siss.flex.utility.ArrayIterator;
	import it.lisit.siss.flex.utility.IIterator;
	/**
	 * Evento scaturito quando un servizio ha dato esito positivo
	 * @author Diego Fossati - Marco Salonia
	 * 
	 */	
	public class ServiceSEBCompleteEvent extends Event
	{
		public static const SERVICE_COMPLETE:String = "serviceComplete";	
		private var response:Array;
		public var iterator:IIterator;
		public function ServiceSEBCompleteEvent(type:String = SERVICE_COMPLETE, listResponse:Array = null /*  array di VoResponse */)
		{
			super(type);
			response	= (listResponse== null) ? new Array() : listResponse;
			iterator	= new ArrayIterator(response); 
		}
		public function getLength():uint
		{
			return response.length;
		}
		public function getResponse(index:uint):VoResponse
		{
			return response[index];
		}
	}
}