package it.lisit.siss.flex.communication.impl.soap
{
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.InvokeEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	/**
	 * HTTP rappresenta un Communicator in grado di comunicare
	 * attraverso chiamate HTTP. 
	 * Opzionale ha bisogno di una stringa di indirizzo HTTP 
	 * dove risiedono i servizi SEB
	 * di default è HTTPCommunicator.SEB_URL;
	 * @author Marco Salonia
	 */
	public class HTTPCommunicator extends Communicator
	{
		/**
		 *  Definisce l'url per l'accesso al server http della PDL SISS
		 */ 
		public static const SEB_URL:String = "http://127.0.0.1:8000";
		/////////////////////////////////////////////////////////////////////////
		private var http:HTTPService;
		public function HTTPCommunicator(url:String = SEB_URL )
		{
			super();
			http 				= new HTTPService();
			http.url 			= url;
			http.contentType 	= HTTPService.CONTENT_TYPE_XML;
			http.method 		= "POST";
			http.resultFormat 	= HTTPService.RESULT_FORMAT_XML;
			http.useProxy 		= false;
			http.addEventListener(FaultEvent.FAULT,onFalut);
			http.addEventListener(ResultEvent.RESULT,onResult);
		}
		override protected function protectedExecute(input:XML):void
		{
			http.send( input );
		}
		private function onResult(e:ResultEvent):void
		{
			responder.result( e );
		}
		private function onFalut(e:FaultEvent):void
		{
			responder.fault( e );
		}
	}
}