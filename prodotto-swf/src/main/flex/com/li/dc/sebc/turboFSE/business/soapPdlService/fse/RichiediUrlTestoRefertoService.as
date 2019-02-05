package com.li.dc.sebc.turboFSE.business.soapPdlService.fse
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.fse.IFactoryFSE;
	import it.lisit.siss.flex.communication.fse.service.AbstractRichiediUrlTestoReferto;
	import it.lisit.siss.flex.communication.fse.voRichiediUrlTestoReferto.VoInputRichiediUrlTestoReferto;
	import it.lisit.siss.flex.communication.fse.voRichiediUrlTestoReferto.VoOutputRichiediUrlTestoReferto;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;

	import mx.rpc.IResponder;

	public class RichiediUrlTestoRefertoService extends FSEService
	{
		public var cittadino:Cittadino;
		public var setDoc:SetDocumentale;

		public function RichiediUrlTestoRefertoService(responder:IResponder=null, factory:IFactoryFSE=null)
		{
			super(responder, factory);
		}

		override protected function getService():AbstractServiceSEB
		{
			return factory.getRichiediUrlTestoReferto() as AbstractServiceSEB;
		}

		override protected function executeService():void
		{
			(this.serviceSEB as AbstractRichiediUrlTestoReferto).execute(getInput());
		}

		override protected function getDataResult(esitiPositivi:Array):Object
		{
			if(esitiPositivi.length > 0)
			{
				var pos:VoOutputRichiediUrlTestoReferto = esitiPositivi[0] as VoOutputRichiediUrlTestoReferto;
				return pos;
			}
			return null;
		}

		private function getInput():VoInputRichiediUrlTestoReferto
		{
			var input:VoInputRichiediUrlTestoReferto = new VoInputRichiediUrlTestoReferto();
			input.codiceFiscale = cittadino.codiceFiscale;
			input.uri = setDoc.documentoTestuale.uri;
			/*if (setDoc.documentoTestuale.firmato == "S")
			{
				input.flagDocumentoFirmato = "SI";
			}
			else
			{
				input.flagDocumentoFirmato = "NO";
			}*/
			input.flagDocumentoFirmato = "NO";
			input.flagCDA2 = "SI";
			return input;
		}
	}
}