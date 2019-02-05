package com.li.dc.sebc.turboFSE.business.soapPdlService.fse
{
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.fse.service.AbstractApriPDT;
	import it.lisit.siss.flex.communication.fse.voApriPDT.VoInputApriPDT;
	import it.lisit.siss.flex.communication.fse.voApriPDT.VoOutputApriPDT;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.DatoCodificato;
	import it.lispa.siss.sebc.middleground.entity.PercorsoDiagnosticoTerapeutico;

	public class ApriPDTService extends FSEService
	{
		public var cittadino:Cittadino;
		public var pdt:PercorsoDiagnosticoTerapeutico;
		public function ApriPDTService()
		{
			super( );
		}
		
		override protected function getDataResult(esitiPositivi:Array):Object
		{
			for(var i:uint = 0;i<esitiPositivi.length;i++)
			{
				var pos:VoOutputApriPDT = esitiPositivi[i] as VoOutputApriPDT;
				if(pos.esitoApriPDT.toUpperCase() == "OK")
				{
					var _pdt:PercorsoDiagnosticoTerapeutico = new PercorsoDiagnosticoTerapeutico();
					_pdt.dataApertura		= this.pdt.dataApertura;
					if(this.pdt.PDT!=null){
						_pdt.PDT			= new DatoCodificato(this.pdt.PDT.codice,this.pdt.PDT.descrizione);
					}else
					{
						_pdt.PDT			= new DatoCodificato("","");
					}
					_pdt.dataChiusura		= UtilDate.formatterDate( new Date() );
					return _pdt;
				}
			}
			// è andato male
			return this.pdt;
		}
		private function getInput():VoInputApriPDT
		{
			var input:VoInputApriPDT 		= new VoInputApriPDT();
			if(pdt.PDT!=null)
			{
				input.codicePDT				= pdt.PDT.codice;
				input.descrizionePDT		= pdt.PDT.descrizione;
			}
			input.dataApertura				= pdt.dataApertura;
			input.nomeCittadino				= cittadino.nome;
			input.cognomeCittadino			= cittadino.cognome;
			if(cittadino.localitaNascita!=null && cittadino.localitaNascita.codiceIstat!=null)
			{
				input.idComuneNascitaCittadino	= cittadino.localitaNascita.codiceIstat;
			}
			input.sessoCittadino 			= cittadino.codiceSesso;
			input.tipoIdCittadino			= "CF";
			input.dataNascitaCittadino		= cittadino.dataNascita;
			return input;	
		}
		override protected function getService():AbstractServiceSEB
		{
			return factory.getApriPDT() as AbstractServiceSEB;
		}	
		override protected function executeService( ):void
		{
			(this.serviceSEB as AbstractApriPDT).execute( getInput() );
		}
	}
}