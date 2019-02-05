package com.li.dc.sebc.turboFSE.business.soapPdlService.fse
{
	import com.li.dc.sebc.turboFSE.business.soapPdlService.PDLService;
	
	import it.lisit.siss.flex.communication.fse.IFactoryFSE;
	
	import mx.rpc.IResponder;

	public class FSEService extends PDLService
	{
		public var factory:IFactoryFSE;
		public function FSEService(responder:IResponder = null ,factory:IFactoryFSE = null)
		{
			super( responder );
			this.factory = factory;
		}
	}
}