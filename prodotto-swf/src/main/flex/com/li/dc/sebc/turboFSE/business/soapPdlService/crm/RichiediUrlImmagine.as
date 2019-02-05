package com.li.dc.sebc.turboFSE.business.soapPdlService.crm
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.crm.IFactoryCRM;
	import it.lisit.siss.flex.communication.crm.service.AbstractRichiediURLImmagine;
	import it.lisit.siss.flex.communication.crm.voRichiediURLImagine.VoInputRichiediURLImmagine;
	import it.lisit.siss.flex.communication.crm.voRichiediURLImagine.VoOutputRichiediURLImmagine;
	
	import mx.rpc.IResponder;

	public class RichiediUrlImmagine extends CRMService
	{
		public var data:Object;
		public var codiceFiscale:String;
		public function RichiediUrlImmagine(responder:IResponder=null, factory:IFactoryCRM=null)
		{
			super(responder, factory);
		}
		override protected function executeService():void
		{
			(this.serviceSEB as AbstractRichiediURLImmagine).execute( getInput() );
		} 
		override protected function getDataResult(esitiPositivi:Array):Object
		{
			if(esitiPositivi.length>0)
			{
				var pos:VoOutputRichiediURLImmagine = esitiPositivi[0] as VoOutputRichiediURLImmagine;
				return pos.urlImmagine;
			}
			return null;
		}
		override protected function getService():AbstractServiceSEB
		{
			return factory.richiediURLImmagine() as AbstractServiceSEB;
		}
		private function getInput( ):VoInputRichiediURLImmagine
		{
			var input:VoInputRichiediURLImmagine = new VoInputRichiediURLImmagine();
			input.codiceFiscale 	= codiceFiscale;
			input.linkImmagine		= data.linkImmagine
			input.linkReferto		= data.linkReferto;
			input.tipoImmagine		= data.tipoImmagine
			return input;
		} 
	}
}