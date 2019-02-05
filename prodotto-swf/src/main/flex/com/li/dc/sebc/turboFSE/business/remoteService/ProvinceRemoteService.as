package com.li.dc.sebc.turboFSE.business.remoteService
{
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.Operatore;
	
	import mx.rpc.IResponder;

	
	public class ProvinceRemoteService extends RemoteService
	{
		
	    public function ProvinceRemoteService(responder:IResponder=null,destination:String=null): void
	    {
	    	super(responder,destination);
	    }
	    /**
	     * 
	     * @param responder
	     */
		override public function execute(): void
	    {
	    	getRemote().getElencoProvince();
	    }

	}//end ContentFolderService

}