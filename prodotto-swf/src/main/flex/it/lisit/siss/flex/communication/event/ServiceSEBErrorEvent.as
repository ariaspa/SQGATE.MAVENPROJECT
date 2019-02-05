package it.lisit.siss.flex.communication.event
{
	import flash.events.Event;
	/**
	 * Un ServiceSEBErrorEvent viene generato quando nel processo della chiamata ad un servizio
	 * un errore di qualsiasi natura viene riscontrato.
	 * Tipicamente diviso in message 'getMessage()' che contiene un messaggio di errore 
	 * e body 'getBody()' contenente, ma non sempre, a sua volta un oggetto di natura variabile  
	 * la natura di questo oggetto non può essere descritta perchè è dipendente  dalla implementazione
	 * del servizio e dagli errori che esso può produrre, così come il messaggio di errore
	 * @author Marco Salonia
	 * 
	 */	
	public class ServiceSEBErrorEvent extends Event
	{
		public static const SERVICE_SEB_ERROR:String = "serviceSebError";
		private var mess:String;
		private var body:Object;
		
		public function ServiceSEBErrorEvent( message:String, body:Object = null , type:String = null)
		{
			super(type==null ? SERVICE_SEB_ERROR : type);
			mess = message;
			this.body = body;
		}
		public function getBody():Object
		{
			return body;
		}
		public function getMessage():String
		{
			return mess;
		}
	}
}