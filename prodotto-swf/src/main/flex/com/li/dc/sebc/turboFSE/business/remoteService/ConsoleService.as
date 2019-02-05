package com.li.dc.sebc.turboFSE.business.remoteService
{
	import mx.rpc.IResponder;

	public class ConsoleService extends RemoteService
	{
		public var message:String;
		public var level:int;
		public function ConsoleService(responder:IResponder=null, destination:String=null)
		{
			super(responder, destination);
		}
		/**
	     * 
	     * @param responder
	     */
		override public function execute(): void
	    {
	    	if(message!=null && level>=0)
	    	{
	    		 getRemote().writeConsole( "FLEX :: "+message, level );
	    	}
	    }

	}
}