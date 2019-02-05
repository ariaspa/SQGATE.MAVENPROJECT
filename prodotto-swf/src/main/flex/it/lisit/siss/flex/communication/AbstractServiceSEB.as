package it.lisit.siss.flex.communication
{
	import flash.events.EventDispatcher;
	
	[Event(name="serviceSebError", type="it.lisit.siss.flex.communication.event.ServiceSEBErrorEvent")]
	[Event(name="serviceSebFault", type="it.lisit.siss.flex.communication.event.ServiceSEBFaultEvent")]
	[Event(name="serviceComplete", type="it.lisit.siss.flex.communication.event.ServiceSEBCompleteEvent")]
	/**
	 * Classe base per tutti i prodotti Seb
	 * @author Diego Fossati - Marco Salonia
	 * 
	 */	
	public class AbstractServiceSEB extends EventDispatcher
	{
		public function AbstractServiceSEB()
		{
			super(this);
		}
	}
}