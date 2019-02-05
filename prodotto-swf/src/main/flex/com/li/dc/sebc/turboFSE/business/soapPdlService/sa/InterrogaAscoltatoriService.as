package com.li.dc.sebc.turboFSE.business.soapPdlService.sa
{
	import com.li.dc.sebc.turboFSE.business.soapPdlService.PDLService;
	
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.sa.IFactorySA;
	import it.lisit.siss.flex.communication.sa.VoInterrogaAscoltatori.VoInputInterrogaAscoltatori;
	import it.lisit.siss.flex.communication.sa.service.AbstractInterrogaAscoltatori;
	
	import mx.rpc.IResponder;

	public class InterrogaAscoltatoriService extends PDLService
	{
		public var factory:IFactorySA;
		public var nomeMetodo:String;
		public var nameSpace:String;
		public function InterrogaAscoltatoriService(responder:IResponder=null)
		{
			super(responder);
		}
		
		
		override protected function getService():AbstractServiceSEB
		{
			return factory.getInterrogaAscoltatori() as AbstractServiceSEB;
		}
		override protected function executeService( ):void
		{
			(this.serviceSEB as AbstractInterrogaAscoltatori).execute( getInput() );
		}
		private function getInput():VoInputInterrogaAscoltatori
		{
			var input:VoInputInterrogaAscoltatori 	= new VoInputInterrogaAscoltatori();
			input.nomeMetodo 						= nomeMetodo;
			input.nameSpace 						= nameSpace;
			return input;	
		}
		override protected function getDataResult(esitiPositivi:Array):Object
		{
			return null;
		}
	}
}