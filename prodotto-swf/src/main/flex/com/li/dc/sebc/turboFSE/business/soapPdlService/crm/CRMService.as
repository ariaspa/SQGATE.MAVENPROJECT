package com.li.dc.sebc.turboFSE.business.soapPdlService.crm
{
	import com.li.dc.sebc.turboFSE.business.soapPdlService.PDLService;
	
	import it.lisit.siss.flex.communication.crm.IFactoryCRM;
	
	import mx.rpc.IResponder;

	public class CRMService extends PDLService
	{
		public var factory:IFactoryCRM;
		public function CRMService(responder:IResponder=null,factory:IFactoryCRM=null)
		{
			super(responder);
			this.factory = factory;
		}
	}
}