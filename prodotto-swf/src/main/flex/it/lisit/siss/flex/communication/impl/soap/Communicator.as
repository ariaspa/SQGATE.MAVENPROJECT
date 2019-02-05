package it.lisit.siss.flex.communication.impl.soap
{
	import mx.rpc.IResponder;
	
	public class Communicator implements ICommunicatorSoap
	{
		protected var responder:IResponder;
		protected var nameService:String;
		public function Communicator( )
		{
		}
		/**
		 * Il metodo execute può sia mandare l'oggetto di input quando presente
		 * o caricare una risorsa o ambe le due cose.
		 * In ogni caso mette in comunicazione Flex con risorse in remoto 
		 * @param input
		 */		
		 final public function execute(nameService:String , responder:IResponder , input:XML  ):void
		 {
		 	this.responder 		= responder;
		 	this.nameService 	= nameService;
		 	protectedExecute(input);
		 }
		 protected function protectedExecute( input:XML ):void
		 {
		 	
		 }
	}
}