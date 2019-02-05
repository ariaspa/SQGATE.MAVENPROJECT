package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * Struttura relativa ad i dati di accettazione
	 * @author Marco Salonia
	 *     
	 */	
	public class VoAccettazione extends ClonableValueObject
	{
		
		/**
		 * Specifica se si tratta di un ricovero in degenza ordinaria oppure un ricovero in Day-Hospital
		 * Stringa alfanumerica di lunghezza 1 carattere.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Regime Ricovero).
		 * Obbligatorietà - SI
		 */		
		public var idRegimeRicovero:String;
		/**
		 * Descrizione del regime di ricovero
		 * Stringa alfanumerica
		 * Obbligatorietà - SI
		 */		
		public var descrizioneRegimeRicovero:String;
		/**
		 * Codice della tipologia di ricovero per il paziente.
		 * Stringa numerica di lunghezza 1 carattere.
		 * Valori ammessi: vedi allegato 1 (Dati codificati –  tabella (Tipo Ricovero).
		 * Obbligatorietà - NO
		 * Quando non presente è valorizzato a null;
		 */		
		public var idTipoRicovero:String = null;
		/**
		 * Descrizione della tipologia di ricovero per il paziente.
		 * Stringa alfanumerica.
		 * Obbligatorietà - NO
		 * Quando non presente è valorizzato a null;
		 */		
		public var descrizioneTipoRicovero:String = null;
		/**
		 * Codice che individua la modalità di accesso alla struttura al momento del ricovero. 
		 * Stringa numerica. Lunghezza 1 caratteri. 
		 * Valori ammessi: vedi allegato 1 (Dati codificati –  tabella Provenienza Paziente).
		 * Obbligatorietà - SI
		 */		
		public var idProvenienzaPaziente:String;
		/**
		 * Descrizione relativa alla modalità di accesso alla struttura al momento del ricovero. 
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var descrizioneProvenienzaPaziente:String;
		/**
		 * Individua il soggetto (o i soggetti) sul quale ricade l'onere di rimborso delle spese relative al ricovero
		 * Stringa alfanumerica di lunghezza 1 carattere.
		 * Valori ammessi: vedi allegato 1 (Dati codificati –  tabella Onere Degenza).
		 * Obbligatorietà - NO
		 * Quando non presente è valorizzato a null;
		 */		
		public var idOnereDegenza:String = null;
		/**
		 * Descrizione dell’onere della degenza
		 * Stringa alfanumerica.
		 * Obbligatorietà - NO
		 * Quando non presente è valorizzato a null;
		 */		
		public var descrizioneOnereDegenza:String = null;
		/**
		 * Identificativo della modalità del trauma.
		 * Stringa numerica.Lunghezza di 1 carattere. 
		 * Valori ammessi: vedi allegato 1 (Dati codificati –  tabella Modalita Trauma)
		 * Obbligatorietà - NO
		 * Quando non presente è valorizzato a null;
		 */		
		public var idModalitaTrauma:String = null;
		/**
		 * Modalità del trauma.
		 * Stringa alfanumerica.
		 * Obbligatorietà - NO
		 * Quando non presente è valorizzato a null;
		 */		
		public var descrizioneModalitaTrauma:String = null;
		/**
		 * Identificativo del numero di prericovero 
		 * Si tratta di una stringa alfanumerica di lunghezza massima uguale a 20.
		 * Obbligatorietà - NO
		 * Quando non presente è valorizzato a null;
		 */		
		public var numeroPrericovero:String = null;
		/**
		 * Identificativo dell’eventuale prescrizione SISS di ricovero
		 * Si tratta di una stringa alfanumerica di lunghezza 10.
		 * Obbligatorietà - NO
		 * Quando non presente è valorizzato a null;
		 */		
		public var IUP:String = null;
		/**
		 * Costituisce la condizione morbosa identificata all'atto dell'accettazione, 
		 * e che risulta essere la principale responsabile del bisogno del trattamento e/o di indagini diagnostiche.
		 * Si tratta di una stringa alfanumerica di lunghezza massima uguale a 1000.
		 * Obbligatorietà - NO
		 * Quando non presente è valorizzato a null;
		 */		
		public var descrizioneDiagnosiIngresso:String = null;
		/**
		 * Codifica in ICD9-CM della diagnosi in ingresso.
		 * Si tratta di una stringa alfanumerica di lunghezza massima 5. Corrisponde alla codifica ICD9-CM della diagnosi.
		 * Obbligatorietà - NO
		 * Quando non presente è valorizzato a null;
		 */		
		public var codiceDiagnosiIngresso:String = null;
		/**
		 * Identificativo dell’accesso di Pronto Soccorso 
		 * Si tratta di una stringa alfanumerica di lunghezza massima uguale a 20 caratteri.
		 * Obbligatorietà - NO
		 * Quando non presente è valorizzato a null;
		 */		
		public var numeroPraticaPS:String = null;
		 /**
		 * Motivo di ricovero in caso di regime di day hospital 
		 * Si tratta di una stringa alfanumerica di lunghezza 1 carattere.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Motivo Ricovero DH).
		 * Obbligatorietà - NO
		 * Quando non presente è valorizzato a null;
		 */		
		public var motivoRicoveroDH:String = null;
		public function VoAccettazione()
		{
			super();
		}
		
	}
}