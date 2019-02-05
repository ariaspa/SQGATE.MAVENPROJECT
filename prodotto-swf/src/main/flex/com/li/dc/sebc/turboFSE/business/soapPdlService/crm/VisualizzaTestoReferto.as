package com.li.dc.sebc.turboFSE.business.soapPdlService.crm
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.crm.IFactoryCRM;
	import it.lisit.siss.flex.communication.crm.service.AbstractVisualizzaTestoReferto;
	import it.lisit.siss.flex.communication.crm.voTestoReferto.VoInputTestoReferto;
	import it.lisit.siss.flex.communication.crm.voTestoReferto.VoOutputTestoreferto;
	import it.lispa.siss.sebc.flex.debug.Debug;
	
	import mx.rpc.IResponder;

	public class VisualizzaTestoReferto extends CRMService
	{
		public var codiceFiscale:String;
		public var uri:String;
		public function VisualizzaTestoReferto(responder:IResponder=null, factory:IFactoryCRM=null)
		{
			super(responder, factory);
		}
		override protected function getService():AbstractServiceSEB
		{
			return factory.getVisualizzaTestoReferto() as AbstractServiceSEB;
		}	
		override protected function executeService( ):void
		{
			Debug.logDebug("VisualizzaTestoReferto.executeService :uri: "+uri+", codiceFiscale : "+codiceFiscale);
			if(uri!=null && codiceFiscale!=null)
			{
				(this.serviceSEB as AbstractVisualizzaTestoReferto).execute( getInput() );
			}
		}
		private function getInput():VoInputTestoReferto
		{
			var input:VoInputTestoReferto 				= new VoInputTestoReferto();
			input.codiceFiscale							= codiceFiscale;
			input.linkReferto							= uri;
			return input;
		}
		override protected function getDataResult(esitiPositivi:Array):Object
		{
			Debug.logDebug("VisualizzaTestoReferto.getDataResult :esitiPositivi.length->: "+esitiPositivi.length);
			if(esitiPositivi!=null && esitiPositivi.length>0)
			{
				var output:VoOutputTestoreferto = esitiPositivi[0] as VoOutputTestoreferto;	
				return {uri:uri,output:output};
			}	
			return null;
		}
	}
}