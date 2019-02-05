package it.lisit.siss.flex.communication.fse.voOttieniDocumentoTestuale
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoCittadino;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAttributiSpecificiDCE;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAutoreDocumento;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoCaratterizzazioniCliniche;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoListaAllegati;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoOperatoreAutorizzante;

	public class VoInputOttieniDocumentoTestuale extends ValueObject
	{
		/**
		 * Codice del tipo di documenti all’interno del fascicolo.
		 * Vincoli:	Stringa alfanumerica di lunghezza 10 caratteri.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Tipo Documenti)
		 * Obbligatorietà - SI
		 */		
		public var idTipoDocumento:String;
		
		/**
		 * Codice della disciplina di erogazione
		 * Stringa alfanumerica di lunghezza 2 caratteri.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Disciplina_SISS).
		 * Obbligatorietà - NO
		 * quando assente assume il valore null
		 */		
		public var disciplinaErogazione:String = null;
		
		/**
		 * Struttura contenente la lista delle caratterizzazioni cliniche relative al DCE pubblicato
		 * Obbligatorietà - NO
		 * quando assente assume il valore null
		 */		
		public var caratterizzazioniCliniche:VoCaratterizzazioniCliniche = null;
		
		/**
		 * Data di creazione del documento clinico elettronico
		 * Vincoli:	
		 * - Data valida formalmente
		 * - Lunghezza di 14 caratteri
		 * - Formato data ammesso  'YYYYMMDDHH24MMSS'.
		 * Obbligatorietà - SI
		 */		
		public var dataOraCreazione:String;
		
		/**
		 * Struttura che contiene le informazioni relative al documento 
		 * Obbligatorietà - SI 
		 */		
		public var documento:VoDocumentoB64;
		
		/**
		 * Struttura contenente l’eventuale  lista di documenti allegati al documento pubblicato, 
		 * tipicamente trattasi di immagini
		 * Obbligatorietà - NO
		 * quando assente assume il valore null
		 */		
		public var listaAllegati:VoListaAllegati = null;
		
		/**
		 * Codifica della rete di patologia dalla quale è stato prodotto il documento clinico
		 * Stringa alfanumerica di lunghezza massima di 10 caratteri.
		 * Obbligatorietà - NO
		 * quando assente assume il valore null
		 */		
		public var reteDiPatologia:String = null;
		
		/**
		 * Indica l’eventuale codifica LOINC attribuita al tipo di DCE pubblicato
		 * Stringa alfanumerica di lunghezza massima di 10 caratteri.
		 * Valori ammessi: vedi allegato 1 Dati codificati –  tabella TipiDocumentiLOINC
		 * Obbligatorietà - NO
		 * quando assente assume il valore null
		 */		
		public var idTipoDocumentoLOINC:String = null;
		
		/**
		 * Struttura dati contenente i dati del cittadino cui è riferito il documento clinico elettronico
		 * Obbligatorietà - SI
		 */		
		public var cittadino:VoCittadino;
		
		/**
		 * Struttura dati contenente i dati del medico che ha compilato il documento
		 * Obbligatorietà - SI
		 */		
		public var autoreDocumento:VoAutoreDocumento
		
		/**
		 * Struttura dati contenente i dati del medico che ha autorizzato 
		 * il cittadino alla consultazione del documento clinico elettronico.
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var operatoreAutorizzante:VoOperatoreAutorizzante = null;
		
		/**
		 * Indica se il cittadino è autorizzato alla consultazione in autonomia del documento clinico.
		 * Stringa alfanumerica di lunghezza massima di 10 caratteri.
		 * Valori ammessi: vedi allegato 1 Dati codificati – tabella Stati Autorizzazione
		 * Obbligatorietà - SI
		 */		
		public var statoAutorizzazioneDocumento:String;
		
		/**
		 * Fornisce al cittadino indicazioni su come avere informazioni e chiarimenti sul 
		 * documento clinico
		 * Vincoli:Stringa alfanumerica di lunghezza 1 KByte.
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var noteReperibilita:String = null;
		
		/**
		 * è caratterizzata da un insieme di tag che cambia in dipendenza del tipo di DCE 
		 */		
		public var attributiSpecificiDCE:VoAttributiSpecificiDCE
		
		public function VoInputOttieniDocumentoTestuale()
		{
			super();
		}
		
	}
}