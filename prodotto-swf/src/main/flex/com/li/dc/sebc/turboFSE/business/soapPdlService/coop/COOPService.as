package com.li.dc.sebc.turboFSE.business.soapPdlService.coop
{
	import com.li.dc.sebc.turboFSE.business.soapPdlService.PDLService;
	
	import it.lisit.siss.flex.communication.coop.IFactoryCOOP;

	public class COOPService extends PDLService
	{
		public var factoryCoop:IFactoryCOOP;
		public function COOPService(factory:IFactoryCOOP = null)
		{
			super();
			this.factoryCoop = factory; 
		}
	}
}