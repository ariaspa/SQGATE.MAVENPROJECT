package it.lisit.siss.flex.communication.impl.soap
{
	import mx.rpc.IResponder;
	
	public interface ICommunicatorSoap
	{
		function execute(nameService:String , responder:IResponder , input:XML ):void
	}
}