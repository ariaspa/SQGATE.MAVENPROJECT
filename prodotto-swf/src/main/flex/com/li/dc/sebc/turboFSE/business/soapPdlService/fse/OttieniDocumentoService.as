package com.li.dc.sebc.turboFSE.business.soapPdlService.fse
{
	import com.li.dc.sebc.turboFSE.util.Utils;
	
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.fse.IFactoryFSE;
	import it.lisit.siss.flex.communication.fse.service.AbstractOttieniDocumentoCDA2;
	import it.lisit.siss.flex.communication.fse.service.AbstractOttieniDocumentoTestuale;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoCittadino;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAutoreDocumento;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoOperatoreAutorizzante;
	import it.lisit.siss.flex.communication.fse.voOttieniDocumentoCDA2.VoInputOttieniDocumentoCDA2;
	import it.lisit.siss.flex.communication.fse.voOttieniDocumentoTestuale.VoDocumentoB64;
	import it.lisit.siss.flex.communication.fse.voOttieniDocumentoTestuale.VoInputOttieniDocumentoTestuale;
	import it.lisit.siss.flex.utility.ArrayIterator;
	import it.lisit.siss.flex.utility.IIterator;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.Documento;
	import it.lispa.siss.sebc.middleground.entity.Medico;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	import mx.rpc.IResponder;
	
	public class OttieniDocumentoService extends FSEService
	{
		public var statoDocVisualizzato:int;
		public var currDocEntry:SetDocumentale;
		public var currDoc:Documento;
		public var cittadino:Cittadino;
		///////////////////////////////////////////
		public var contenutoB64:String;
		public var noteReperibilta:String;
		
		public function OttieniDocumentoService(responder:IResponder = null ,factory:IFactoryFSE = null)
		{
			super(responder, factory);
			statoDocVisualizzato = -1;
		}
		
		override protected function getDataResult(esitiPositivi:Array):Object
		{
			if (esitiPositivi.length >= 1)
			{
				return true;
			}
			return false;
		}
		override protected function getService():AbstractServiceSEB
		{
			//se statoDocVisualizzato == 1 viene salvato il documento testuale,
			if (statoDocVisualizzato == 1)
			{
				return factory.getOttieniDocumentoTestuale() as AbstractServiceSEB;
			}else if (statoDocVisualizzato == 2)
			{
				//se statoDocVisualizzato == 2 viene salvato il documento strutturato,
				return factory.getOttieniDocumentoCDA2() as AbstractServiceSEB;
			}
			return null;
		}	
		override protected function executeService( ):void
		{
			if(currDocEntry!=null && currDoc!=null && cittadino!=null)
			{
				//se statoDocVisualizzato == 1 viene salvato il documento testuale,
				if (statoDocVisualizzato == 1)
				{
					(this.serviceSEB as AbstractOttieniDocumentoTestuale).execute( getInputTestuale() );
				}else if (statoDocVisualizzato == 2)
				{
					//se statoDocVisualizzato == 2 viene salvato il documento strutturato,
					(this.serviceSEB as AbstractOttieniDocumentoCDA2).execute( getInputCDA2() );
				}
			}
		}
		private function getInputCDA2():VoInputOttieniDocumentoCDA2 
		{
			var input:VoInputOttieniDocumentoCDA2 = new VoInputOttieniDocumentoCDA2();
			return fillInput( input as VoInputOttieniDocumentoTestuale) as VoInputOttieniDocumentoCDA2;
		}
		private function getInputTestuale():VoInputOttieniDocumentoTestuale
		{
			var input:VoInputOttieniDocumentoTestuale = new VoInputOttieniDocumentoTestuale();
			return fillInput(input);
		}
		///////////////////////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////////////////////
		private function fillInput(input:VoInputOttieniDocumentoTestuale):VoInputOttieniDocumentoTestuale 
		{
			input.idTipoDocumento 		= Utils.getCodice(currDocEntry.tipoDocumento);
			input.disciplinaErogazione 	= Utils.getCodice(currDocEntry.disciplinaErogazione);	
			input.dataOraCreazione 		= currDocEntry.dataOraCreazione;
			if(currDocEntry.caratterizzazioniCliniche!=null)
			{
				input.caratterizzazioniCliniche = new VoCaratterizzazioniClinicheImpl(currDocEntry.caratterizzazioniCliniche.toArray());
			}
			var doc:VoDocumentoB64 	= new VoDocumentoB64();
			doc.idSetDocumenti 		= currDocEntry.idSetDocumenti;
			doc.nVersione 			= Number(currDocEntry.nVersione);
			doc.linguaggioDocumento = currDoc.linguaggioDocumento;
			doc.formato 			= currDoc.formato
			doc.contenuto 			= contenutoB64;
			doc.uri 				= currDoc.uri;
			doc.hashDocumento 		= currDoc.hashDocumento;
			doc.algoritmoHash 		= currDoc.algoritmoHash;
			doc.sizeDocumento 		= currDoc.sizeDocumento;
			input.documento 		= doc;
			if(currDocEntry.listaAllegati!=null)
			{
				var allImpl:VoListaAllegatiImpl = new VoListaAllegatiImpl(currDocEntry.listaAllegati.toArray());
				input.listaAllegati 			= allImpl;
			}
			input.reteDiPatologia 				= Utils.getCodice(currDocEntry.reteDiPatologia);
			input.idTipoDocumentoLOINC 			= currDocEntry.idTipoDocumentoLOINC;
			input.cittadino 					= getVoCittadino();
			if(currDocEntry.autoreDocumento!=null)
			{
				input.autoreDocumento 			= getAutoreDocumento(currDocEntry.autoreDocumento);
			}
			if(currDocEntry.operatoreAutorizzante!=null){
				input.operatoreAutorizzante 	= getOperatoreAutorizzante(currDocEntry.operatoreAutorizzante);
			}
			input.statoAutorizzazioneDocumento 	= currDocEntry.statoAutorizzazioneDocumento;
			input.noteReperibilita 				= noteReperibilta;
			return input;
		}
		
		private function getVoCittadino():VoCittadino {
			var voCitt:VoCittadino 	= new VoCittadino();
			voCitt.cognomeCittadino = cittadino.cognome;
			voCitt.idCittadino 		= cittadino.codiceFiscale;
			voCitt.nomeCittadino 	= cittadino.nome;
			voCitt.tipoIdCittadino 	= "CF";
			return voCitt;
		}
		
		private function getAutoreDocumento(medico:Medico):VoAutoreDocumento {
			 
			var autore:VoAutoreDocumento = new VoAutoreDocumento();
			autore.cognome = medico.cognome;
			autore.codiceFiscale = medico.codiceFiscale;
			autore.nome = medico.nome;
			autore.ruolo = medico.ruolo.codice;
			return autore;
		}
		
		private function getOperatoreAutorizzante(medico:Medico):VoOperatoreAutorizzante {
			var operatore:VoOperatoreAutorizzante = new VoOperatoreAutorizzante();
			operatore.cognomeAutorizzante = medico.cognome;
			operatore.codiceFiscaleAutorizzante = medico.codiceFiscale;
			operatore.nomeAutorizzante = medico.nome;
			return operatore;
		}
	}
}

import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAllegato;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoCaratterizzazione;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoCaratterizzazioniCliniche;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoListaAllegati;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo2009.VoAllegato2009;
import it.lisit.siss.flex.utility.ArrayIterator;
import it.lisit.siss.flex.utility.IIterator;
import it.lispa.siss.sebc.middleground.entity.Allegato;
import it.lispa.siss.sebc.middleground.entity.Caratterizzazione;


class VoCaratterizzazioniClinicheImpl extends VoCaratterizzazioniCliniche {
	
	private var iter:IIterator;
	public function VoCaratterizzazioniClinicheImpl(ar:Array) {
		super();
		var myArr:Array = new Array();
		for (var i:int = 0; i < ar.length; i++) {
			var voCarat:VoCaratterizzazione = getVoCaratterizzazione(ar[i] as Caratterizzazione)
			myArr.push(voCarat);
		}
		iter = new ArrayIterator(myArr);
	}
	
	private function getVoCaratterizzazione(carat:Caratterizzazione):VoCaratterizzazione
	{
		var voCarat:VoCaratterizzazione = new VoCaratterizzazione();
		voCarat.codice 					= carat.codice;
		voCarat.dizionario 				= carat.dizionario;
		return voCarat
	}
	
	override public function get iterator():IIterator {
		return iter;
	}
}

class VoListaAllegatiImpl extends VoListaAllegati {
	
	private var iter:IIterator;
	public function VoListaAllegatiImpl(ar:Array) {
		super();
		var myArr:Array = new Array();
		for (var i:int = 0; i < ar.length; i++) {
			var voAllegato:VoAllegato2009 = getAllegato(ar[i] as Allegato)
			myArr.push(voAllegato);
		}
		iter = new ArrayIterator(myArr);
	}
	
	private function getAllegato(allegato:Allegato):VoAllegato2009 
	{
		var voAllegato:VoAllegato2009 = new VoAllegato2009();
		voAllegato.etichettaAllegato = allegato.etichettaAllegato;
		voAllegato.formatoAllegato = allegato.formatoAllegato;
		voAllegato.linkAllegato = allegato.linkAllegato;
		return voAllegato;
	}
	
	override public function get iterator():IIterator {
		return iter;
	}
}