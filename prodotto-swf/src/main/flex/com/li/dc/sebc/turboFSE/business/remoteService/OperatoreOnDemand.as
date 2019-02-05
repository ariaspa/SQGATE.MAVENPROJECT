package com.li.dc.sebc.turboFSE.business.remoteService
{
	import mx.rpc.IResponder;

	public class OperatoreOnDemand extends RemoteService
	{
		public function OperatoreOnDemand(responder:IResponder=null, destination:String=null)
		{
			super(responder, destination);
		}
		override public function execute():void
		{
			getRemote().getOperatoreOnDemand();
		}
	}
}