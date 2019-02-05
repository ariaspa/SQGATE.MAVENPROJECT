package com.li.dc.sebc.turboFSE.business.remoteService
{
	import mx.rpc.IResponder;

	public class ParametriVariabiliRemoteService extends RemoteService
	{
		public function ParametriVariabiliRemoteService(responder:IResponder=null, destination:String=null)
		{
			super(responder, destination);
		}

		override public function execute(): void
		{
			getRemote().getParametriVariabili();
		}
	}
}