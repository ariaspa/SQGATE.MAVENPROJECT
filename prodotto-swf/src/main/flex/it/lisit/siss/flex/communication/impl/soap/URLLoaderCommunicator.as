package it.lisit.siss.flex.communication.impl.soap
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.utility.debug.Debug;
	/**
	 * URL_LOADER rappresenta un ICommunicatorSoap in grado di comunicare,
	 * o meglio, caricare risorse xml, attraverso chiamate url. 
	 * Ha bisogno di un array di indirizzi per accedere alle risorse.
	 * La forma dell'array è questa:
	 * [{servizio:nomeServizio1,url:indirizzo1}, {servizio:nomeServizio2,url:indirizzo2}] 
	 * ad esempio se il servizio è FSE:Consultafascicolo verra scritto nell'array
	 * [ {servizio:"FSE:Consultafascicolo" ,url:"../xml/output.xml"} ] 
	 * @author Marco Salonia
	 */ 
	public class URLLoaderCommunicator extends Communicator
	{
		private var listURL:Array;
		public function URLLoaderCommunicator(params:Array)
		{
			super();
			listURL = params;
		}
		override protected function protectedExecute(input:XML):void
		{
			var url:String 						= findUrl();
			if(url == null || url.length==0) throw new SebException("URLLoaderCommunicator, non trovato url corrispondente a "+this.nameService , SebException.IMPL_ERROR);
			var requestXMLURL:URLRequest 		= new URLRequest(url);
			var contentXMLLoader:URLLoader 		= new URLLoader( );
			addListener(contentXMLLoader);
			contentXMLLoader.load(   requestXMLURL  );
		}
		private function removeListener(listener:URLLoader):void
		{
			listener.removeEventListener(Event.COMPLETE, xmlLoaded);
			listener.removeEventListener(IOErrorEvent.IO_ERROR,onIoError);
			listener.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
		}
		private function addListener(listener:URLLoader):void
		{
			listener.addEventListener(Event.COMPLETE, xmlLoaded);
			listener.addEventListener(IOErrorEvent.IO_ERROR,onIoError);
			listener.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
		}
		private function onIoError(e:IOErrorEvent):void
		{
			var target:URLLoader = e.target as URLLoader;
			removeListener(target);
			responder.fault(e.text);
		}
		private function onSecurityError(e:SecurityErrorEvent):void
		{
			var target:URLLoader = e.target as URLLoader;
			removeListener(target);
			responder.fault(e.text);
		}
		private function xmlLoaded(e:Event):void
		{
			var target:URLLoader = e.target as URLLoader;
			removeListener(target);
			var xml:XML;
			try{
				xml		 = new XML(target.data);
			}catch(er:Error)
			{
				responder.fault(er.message);
			}
			responder.result( xml );
		}	
		//[ {servizio:"FSE:Consultafascicolo" ,url:"../xml/output.xml"} ] 
		private function findUrl( ):String
		{
			
			if(this.nameService !=null )
			{
				for(var i:uint = 0;i<listURL.length;i++)
				{
					var servizio:String = listURL[i].servizio;
					if(servizio != null && servizio == this.nameService )
					{
						return listURL[i].url;
					}
				}
			}
			return null;
		}
	}
}