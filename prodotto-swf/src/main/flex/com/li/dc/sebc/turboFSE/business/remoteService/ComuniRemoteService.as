package com.li.dc.sebc.turboFSE.business.remoteService
{
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.Operatore;
	
	import mx.rpc.IResponder;

	
	public class ComuniRemoteService extends RemoteService
	{
		public var codiceProvincia:String;
		
	    public function ComuniRemoteService(responder:IResponder=null,destination:String=null, codiceProvincia:String=null): void
	    {
	    	super(responder,destination);
	    	this.codiceProvincia = codiceProvincia;
	    }
	    /**
	     * 
	     * @param responder
	     */
		override public function execute(): void
	    {
			if (codiceProvincia != null)
	    		getRemote().getElencoComuni(codiceProvincia);
			else
				callInternalFault("Il parametro codiceProvincia risulta vuoto");
	    	
	    }

	}//end ContentFolderService

}