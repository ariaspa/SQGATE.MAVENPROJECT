package com.li.dc.sebc.turboFSE.business.soapPdlService.icce
{
	import com.li.dc.sebc.turboFSE.business.soapPdlService.PDLService;
	
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.icce.IFactoryICCE;
	import it.lisit.siss.flex.communication.icce.service.AbstractServiceIdentificaCittadinoEsteso2008_01;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoDatiCittadino;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoInputIdentificaCittadinoEsteso;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoOutputIdentificaCittadinoEsteso2008_01;
	import it.lispa.siss.sebc.middleground.entity.Assistenza;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.Comune;
	import it.lispa.siss.sebc.middleground.entity.Consenso;
	import it.lispa.siss.sebc.middleground.entity.DatoCodificato;
	import it.lispa.siss.sebc.middleground.entity.Indirizzo;
	import it.lispa.siss.sebc.middleground.entity.supporto.SmartCard;
	
	import mx.rpc.IResponder;

	public class IdentificaCittadinoSmartCard extends PDLService
	{
		public var factoryIcce:IFactoryICCE;
		public function IdentificaCittadinoSmartCard(responder:IResponder=null)
		{
			super(responder);
		}
		override protected function getService():AbstractServiceSEB
		{
			return factoryIcce.getServiceIdentificaCittadino() as AbstractServiceSEB;
		}	
		override protected function executeService( ):void
		{
			(this.serviceSEB as AbstractServiceIdentificaCittadinoEsteso2008_01).execute(new VoInputIdentificaCittadinoEsteso());
		}
		
		/**
		 * La trasformazione in un oggetto dei risultati 
		 * @param esitiPositivi
		 * @return 
		 * 
		 */		
		override protected function getDataResult(esitiPositivi:Array):Object
		{
			var citt:Cittadino = new Cittadino();
			if(esitiPositivi!=null && esitiPositivi.length>0 )
			{
				var out:VoOutputIdentificaCittadinoEsteso2008_01 = esitiPositivi[0] as VoOutputIdentificaCittadinoEsteso2008_01;
				var voCittadino:VoDatiCittadino = getDataCittadino(out);
				if(voCittadino!=null)
				{
					fillCittadino(citt,voCittadino);
				}
			}
			return citt;
		}
		private function fillCittadino(citt:Cittadino,voCittadino:VoDatiCittadino):void
		{
			citt.nome						= voCittadino.nomeCittadino;
			citt.cognome					= voCittadino.cognomeCittadino;
			citt.codiceFiscale				= voCittadino.codiceFiscaleCittadino;
			citt.codiceSesso				= voCittadino.sessoCittadino;
			citt.dataNascita				= voCittadino.dataNascitaCittadino;
			/*  sono in dubbio */
			citt.dataUltimaModifica			= voCittadino.dataUltimaVariazioneAnagrafici;
			//
			fillAssistenza( citt.assistenza, voCittadino);
			fillCittadinanza( citt.cittadinanza, voCittadino);
			fillConsenso( citt.consenso, voCittadino);
			fillDomicilio(citt.domicilio, voCittadino);
			fillLocalitaNascita(citt.localitaNascita, voCittadino);
			fillResidenza(citt.residenza, voCittadino);
			fillSmartCard(citt.smartCard, voCittadino);
		}
		private function fillSmartCard(smartcard:SmartCard,voCittadino:VoDatiCittadino):void
		{
			
		}
		private function fillLocalitaNascita(comune:Comune,voCittadino:VoDatiCittadino):void
		{
			//comune.codiceIstat			= voCittadino.idComuneNascitaCittadino
			comune.descrizione			= voCittadino.comuneNascitaCittadino;
			comune.provincia			= voCittadino.provinciaNascitaCittadino;
		}
		private function fillResidenza(residenza:Indirizzo,voCittadino:VoDatiCittadino):void
		{
			residenza.cap			= voCittadino.capResidenzaCittadino
			residenza.civico		= voCittadino.civicoResidenzaCittadino;
			residenza.comune		= new Comune();
			residenza.comune.descrizione	= voCittadino.comuneResidenzaCittadino;
			residenza.comune.provincia		= voCittadino.provinciaResidenzaCittadino;
			residenza.indirizzo		= voCittadino.indirizzoResidenzaCittadino;
		}
		private function fillDomicilio(indirizzo:Indirizzo,voCittadino:VoDatiCittadino):void
		{
			indirizzo.cap			= voCittadino.capDomicilioCittadino;
			indirizzo.civico		= voCittadino.civicoDomicilioCittadino;
			indirizzo.comune				=	new Comune();
			indirizzo.comune.provincia		= voCittadino.provinciaDomicilioCittadino;
			indirizzo.comune.descrizione	= voCittadino.comuneDomicilioCittadino;  
			indirizzo.indirizzo		= voCittadino.indirizzoDomicilioCittadino;
		}
		private function fillConsenso(consenso:Consenso,voCittadino:VoDatiCittadino):void
		{
			//consenso.dataRegistrazione
			//consenso.stato		
		}
		private function fillAssistenza(assistenza:Assistenza,voCittadino:VoDatiCittadino):void
		{
			assistenza.dataDecorrenzaIscrizione			= voCittadino.dataDecorrenzaIscrizione;
			assistenza.dataScadenzaIscrizione			= voCittadino.dataScadenzaIscrizione;
			assistenza.descrizioneAslAppartenenza		= voCittadino.descrizioneAslAppartenenza
			assistenza.descrizioneAslAssistenza			= voCittadino.descrizioneAslAssistenza;
			//assistenza.idAssistito						= voCittadino.id;	
			assistenza.idProvenienza					= voCittadino.idProvenienza;
			assistenza.siglaAslAppartenenza				= voCittadino.siglaAslAppartenenza;
			assistenza.siglaAslAssistenza				= voCittadino.siglaAslAssistenza;
			assistenza.statoAssistito					= voCittadino.statoAssistito;
			//assistenza.unicId							= voCittadino
		}
		private function fillCittadinanza(cittadinanza:DatoCodificato,voCittadino:VoDatiCittadino):void
		{
			//cittadinanza.codice			= voCittadino.
			//cittadinanza.descrizione		= voCittadino
		}
		private function getDataCittadino(out:VoOutputIdentificaCittadinoEsteso2008_01):VoDatiCittadino
		{
			if(out.rispostaSingola!=null && out.rispostaSingola.datiCittadino!=null)
			{
				return out.rispostaSingola.datiCittadino;
			}
			return null;
		}
	}
}