package it.lisit.siss.flex.communication.impl.soap
{
	import mx.rpc.IResponder;

	/**
	 * Classe delegata alla chiamata del servizio
	 * @author Diego Fossati
	 */	
	internal final class ServiceSendXML
	{
		private var communicator:ICommunicatorSoap;
		private var responder:IResponder;
		private var nameService:String;
		public function ServiceSendXML(communicator:ICommunicatorSoap,responder:IResponder,nameService:String)
		{
			this.communicator 	= communicator;
			this.responder 		= responder;
			this.nameService 	= nameService;
		}
		public function send(input:XML):void
		{
			this.communicator.execute(nameService,responder,input);
		}
	}
}