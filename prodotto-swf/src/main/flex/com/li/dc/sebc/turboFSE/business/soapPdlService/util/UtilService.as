package com.li.dc.sebc.turboFSE.business.soapPdlService.util
{
	import com.li.dc.sebc.turboFSE.business.soapPdlService.PDLService;
	
	import it.lisit.siss.flex.communication.util.IFactoryUtils;
	
	import mx.rpc.IResponder;

	public class UtilService extends PDLService
	{
		public var factory:IFactoryUtils;
		public function UtilService(responder:IResponder=null,factory:IFactoryUtils=null)
		{
			super(responder);
			this.factory = factory;
		}
	}
}